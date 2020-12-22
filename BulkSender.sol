pragma solidity >= 0.6.2;

import 'utils/MessageUtil.sol';
import 'modifiers/TransferValueModifier.sol';

/**
 * Error codes
 *     • 100 — Method only for the owner
 *     • 101 — Message is too long
 *     • 102 — Length isn't same
 *     • 103 — Not enough balance
 *     • 200 — Invalid transfer value
 */
contract BulkSender is MessageUtil,
                       TransferValueModifier {
    /*************
     * CONSTANTS *
     *************/
    uint128 private constant MIN_BALANCE        = 1e9; // 1💎
    uint16  private constant MAX_MESSAGE_LENGTH = 128;



    /*************
     * MODIFIERS *
     *************/
    modifier accept {
        tvm.accept();
        _;
    }

    modifier onlyOwner {
        require(msg.pubkey() == tvm.pubkey(), 100, "Method only for owner");
        _;
    }



    /***********************
     * PUBLIC * ONLY OWNER *
     ***********************/
    function sendTransaction(
        address destination,
        uint128 value
    ) public view onlyOwner accept validTransferValue(value) {
        destination.transfer(value);
    }

    function destroy(address destination) public onlyOwner accept {
        selfdestruct(destination);
    }

    function transfer(
        address[] destinations,
        uint128[] values,
        uint8[]   message
    ) public view onlyOwner accept {
        require(message.length <= MAX_MESSAGE_LENGTH, 101, "Message is too long");
        require(destinations.length == values.length, 102, "Length isn't same");

        uint128 amount = MIN_BALANCE;
        for (uint64 i = 0; i < values.length; i++)
            amount += values[i];
        require(amount < address(this).balance, 103, "Not enough balance");

        TvmCell body = _getTransferBody(message);
        for (uint64 i = 0; i < destinations.length; i++) {
            address destination = destinations[i];
            uint128 value = values[i];
            destination.transfer({value: value, body: body});
        }
    }
}