package SFISB;
    //assembly registers
    localparam int ISB_ASSM_REGS_TAG_WIDTH  = 8;
    localparam int _BYTE_BITS               = 8; // "Hidden" because may be defined elsewhere

    // Used by SeaDragon ISB
    localparam int AXI_ADDR_WIDTH = 48;
    localparam int AXI_DATA_WIDTH = 64;
    localparam int AXI_DATA_MAX_BIT = 63;
    localparam int AXI_ADDRESS_MAX_BIT = AXI_ADDR_WIDTH-1;
    localparam int AXI_AUSER_WIDTH = 2;
    localparam int AXI_BUSER_WIDTH = 2;

    //Not used by SeaDragon but probably needed by verification IP.
    localparam int AXI_PROT_WIDTH = 3;
    localparam int AXI_RESP_WIDTH = 2;
    localparam int AXI_WSTRB_WIDTH = 8;
    localparam int AXI_WSTRB_MAX_BIT = 7;


    localparam int ISB_ADDR_WIDTH = AXI_ADDR_WIDTH;
    localparam int ISB_DATA_WIDTH = AXI_DATA_WIDTH;
    localparam int ISB_DATA_BYTES = ISB_DATA_WIDTH/_BYTE_BITS;
    localparam int ISB_AUSER_WIDTH = AXI_AUSER_WIDTH;
    localparam int ISB_BUSER_WIDTH = AXI_BUSER_WIDTH;
    localparam logic [ISB_ADDR_WIDTH-1:0] ISB_ADDR_ZERO      = {ISB_ADDR_WIDTH{1'b0}};
    localparam logic [ISB_DATA_WIDTH-1:0] ISB_DATA_ZERO      = {ISB_DATA_WIDTH{1'b0}};
    localparam logic [ISB_AUSER_WIDTH-1:0] ISB_AUSER_ZERO    = {ISB_AUSER_WIDTH{1'b0}};
    localparam logic [AXI_RESP_WIDTH-1:0] ISB_RESP_ZERO      = {AXI_RESP_WIDTH{1'b0}};

    typedef logic[ISB_ADDR_WIDTH-1:0] ISBAddr_t;
    typedef logic[ISB_DATA_WIDTH-1:0] ISBData_t;

    // Number of top-level logic buses.Number of top-level buses
    localparam int  NUM_BUSES     = 10;
    localparam int  BUS_ID_WIDTH  = 4;

    localparam int  RDY2VALID_DELAY = 2; //HG this define is not used in ISBctl rtl

    //localparam AUCLEAR  = 1;   // auser[AUCLEAR]
    localparam AUWAKE   = 1;
    localparam AUEXEC   = 0;   // auser[AUEXEC]
    localparam AUNONPIPE= 0;   // auser[AUNONPIPE]
    localparam BUACK    = 0;   // buser[BUACK]
    localparam BUNONPIPE= 0;   // buser[BUNONPIPE]
    localparam BUWAKE   = 1;

     // For detailed decoding, use sfISBAddressDecoder

    // AXI4-Lite interface with merged address bus
    typedef struct packed
    {
        // The address channel signals
        logic                           arvalid; // Read address valid
        logic                           awvalid; // Read address valid
        logic [AXI_ADDRESS_MAX_BIT:0]   aaddr;   // Read address
        logic [AXI_AUSER_WIDTH-1:0]     auser;   // User defined control

        // The write data channel signals
        logic [AXI_DATA_MAX_BIT:0]      wdata;   // Write data

        // The write-resp channel signals
        logic                           bvalid;  // Write response valid
        logic [AXI_BUSER_WIDTH-1:0]     buser;

        // The read channel signals
        logic                           rvalid;  // Read valid
        logic [AXI_DATA_MAX_BIT:0]      rdata;   // Read data

        // The ready signals
        logic                           arready;  // Read ready
        logic                           awready;  // Write ready

    } ISBSignals_t;




        // AXI4-Lite interface with merged address bus
    typedef struct packed
    {
        // The address channel signals
        logic [AXI_AUSER_WIDTH-1:0]     auser;   // User defined control
        logic                           arvalid; // Read address valid
        logic                           awvalid; // Write address valid
        logic [AXI_ADDRESS_MAX_BIT:0]   aaddr;   // address
        // The write data channel signals
        logic [AXI_DATA_MAX_BIT:0]      wdata;   // Write data
    } ISBMasterSignals_t;

      typedef struct packed
    {
        // The write-resp channel signals
        logic                           bvalid;  // Write response valid
        logic [AXI_BUSER_WIDTH-1:0]     buser;

        // The read channel signals
        logic                           rvalid;  // Read valid
        logic [AXI_DATA_MAX_BIT:0]      rdata;   // Read data

        // The ready signals
        logic                           arready;  // Read ready
        logic                           awready;  // Write ready

    } ISBSlaveSignals_t;


    typedef struct packed
    {
        logic                           isb_chk_iof_space_dis;  // 11
        logic                           isb_M8trans_chain_dis;  // 10
        logic                           isb_trans_chain_en_wr;  //  9
        logic                           isb_trans_chain_en_rd;  //  8
        logic [7:0]                     isb_trans_chains_max;   //7:0
    } ISBTransChain_t;

    localparam ISB_WAKE_CTL_BITS = 128;
