pragma solidity >= 0.6.2;

contract MessageUtil {
    /*************
     * CONSTANTS *
     *************/
    uint16 private constant MESSAGE_PREFIX_BITS = 0x20; // 32-bit prefix that contains zeros
    uint16 private constant UTF8_CHARACTER_BITS = 0x8;  // 8-bit UTF-8 encoded character



    /********
     * PURE *
     ********/
    /**
     * Returns TvmCell with message.
     */
    function _getTransferBody(uint8[] message) internal pure returns (TvmCell) {
        TvmBuilder builderString;
        for (uint64 i = 0; i < message.length; i++)
            builderString.storeUnsigned(message[i], UTF8_CHARACTER_BITS);
        TvmBuilder builder;
        builder.storeUnsigned(0, MESSAGE_PREFIX_BITS);
        builder.storeRef(builderString);
        return builder.toCell();
    }
}