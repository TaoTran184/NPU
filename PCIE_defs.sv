`ifndef	    __SFPCIE_DEFS_SV__
`define	    __SFPCIE_DEFS_SV__


package SFPCIe;

    parameter int TAG_W = 5;
    parameter int MAX_TAG = (1 << TAG_W) - 1;
    parameter int APB_ADDR_WIDTH = 16; 

    /************************************************
     *		      Standard PCI Express	    *
     ************************************************/

    typedef enum logic [6:0] {
	ePCIeMRd3	= 7'b00_00000,
	ePCIeMRd4	= 7'b01_00000,
	ePCIeMWr3	= 7'b10_00000,
	ePCIeMWr4	= 7'b11_00000,
	ePCIeIORd	= 7'b00_00010,
	ePCIeIOWr	= 7'b10_00010,
	ePCIeMsg	= 7'b01_10000,	// 01_10rrr
	ePCIeMsgD	= 7'b11_10000,	// 11_10rrr
	ePCIeMsgSig	= 7'b01_11000,	// ff_tt---
	ePCIeCpl	= 7'b00_01010,
	ePCIeCplD	= 7'b10_01010
    } PCIeFmtType;

    typedef enum logic [2:0] {
	ePCIeSuccess	= 0,
	ePCIeUnsup	= 1,
	//Retry		= 2,		// config only
	ePCIeAbort	= 4
    } PCIeCplStatus;

  
      typedef struct packed {
	logic		_rsvd0;		// [	127] {tlp prefix}
	PCIeFmtType	fmttype;	// [126:120]
	logic		_rsvd1;		// [	119]
	logic [ 2:0]	tc;		// [118:116]
	logic [ 3:0]	_rsvd2;		// [115:112] {x,attr2,x,ph}
	logic		td;		// [	111]
	logic		ep;		// [	110]
	logic [ 1:0]	attr;		// [109:108]
	logic [ 1:0]	_rsvd3;		// [107:106] {at}
	logic [ 9:0]	length;		// [105: 96]

	logic [15:0]	reqid;		// [ 95: 80]
	logic [ 7:0]	tag;		// [ 79: 72]
	logic [ 3:0]	lastbe;		// [ 71: 68]
	logic [ 3:0]	firstbe;	// [ 67: 64]

	logic [61:0]	addr;		// [ 63:  2]
	logic [ 1:0]	_rsvd4;		// [  1:  0]
    } PCIeReqMem;

    typedef struct packed {
	logic		_rsvd0;		// [	127] {tlp prefix}
	PCIeFmtType	fmttype;	// [126:120]
	logic		_rsvd1;		// [	119]
	logic [ 2:0]	tc;		// [118:116]
	logic [ 3:0]	_rsvd2;		// [115:112] {x,attr2,x,ph}
	logic		td;		// [	111]
	logic		ep;		// [	110]
	logic [ 1:0]	attr;		// [109:108]
	logic [ 1:0]	_rsvd3;		// [107:106] {at}
	logic [ 9:0]	length;		// [105: 96]

	logic [15:0]	reqid;		// [ 95: 80]
	logic [ 7:0]	tag;		// [ 79: 72]
	logic [ 7:0]	code;		// [ 71: 64]

	logic [15:0]	_cplid;		// [ 63: 48] NA from HAL
	logic [15:0]	_vender;	// [ 47: 32]

	logic [31:0]	_vdef;		// [ 31:  0]
    } PCIeReqMsg;

      typedef enum logic [2:0] {
	eTgtMemRd	= 3'b000,
	eTgtIORd	= 3'b001,
	eTgtMemWr	= 3'b010,
	eTgtIOWr	= 3'b011,
	eTgtMsg		= 3'b100,
	eTgtMsgVD	= 3'b101,
	eTgtAtom	= 3'b110
    } PCIeHalTgtType;

    typedef enum logic [1:0] {
	eCplSuccess	= 2'b00,
	eCplUnSup	= 2'b01,
	eCplAbort	= 2'b10,
	eCplRetrySts	= 2'b11
    } PCIeHalCplCode;

    typedef struct packed {
	logic [ 7:0]	mcode;		// [127:120] msg code
	logic [ 7:0]	_tgtfn;		// [119:112] 0
	logic [ 2:0]	bar;		// [111:109] mem: 0 or 2, msg: rout
	logic [ 1:0]	_rsvd;		// [108:107]
	logic [ 2:0]	tc;		// [106:104]
	logic [ 7:0]	tag;		// [103: 96]
	logic [15:0]	reqid;		// [ 95: 80]
	logic [12:0]	blen;		// [ 79: 67]
	PCIeHalTgtType	ttype;		// [ 66: 64]
	logic [63:0]	addr;		// [ 63:  0]
    } PCIeHalTgtReq;

    typedef struct packed {
	logic [ 7:0]	_tgtfn;		// [127:120] 0
	logic [12:0]	bcount;		// [119:107] remaining byte count
	logic [ 2:0]	tc;		// [106:104]
	logic [ 7:0]	tag;		// [103: 96]
	logic [15:0]	reqid;		// [ 95: 80]
	logic		ep;		// [	 79]
	PCIeHalCplCode	code;		// [ 78: 77]
	logic [12:0]	blen;		// [ 76: 64]
	logic [52:0]	_rsvd;		// [ 63: 11]
	logic		_ecrc;		// [	 10] 0, force ecrc
	logic [2:0]	attr;		// [  9:  7]
	logic [6:0]	addr;		// [  6:  0] byte addr lsb
    } PCIeHalTgtCpl;

    typedef enum logic [3:0] {
	eMstMemRd	= 4'b0000,
	eMstMemWr	= 4'b0010,
	eMstMsg		= 4'b1100,
	eMstUnSup	= 4'b1111
    } PCIeHalMstType;

    typedef struct packed {
	logic [ 2:0]	mrout;		// [127:125] msg rout
	logic [ 4:0]	tag;		// [124:120] client supplied
	logic [ 7:0]	_cplbus;	// [119:112] 0, cfg only
	logic [ 7:0]	mcode;		// [111:104] msg code
	logic [15:0]	_reqid;		// [103: 88] 0, when _cliid==1
	logic		_cliid;		// [	 87] 0, client supplies reqid
	logic		_rsvd;		// [	 86]
	logic		_ecrc;		// [	 85] 0, force
	logic		ep;		// [	 84]
	logic [ 2:0]	tc;		// [ 83: 81]
	logic [12:0]	blen;		// [ 80: 68]
	PCIeHalMstType	ttype;		// [ 67: 64]
	logic [63:0]	addr;		// [ 63:  0]
    } PCIeHalMstReq;

    typedef enum logic[2:0] {
	eErrNormal	= 3'b000,
	eErrPoison	= 3'b001,
	eErrAbnorm	= 3'b010,
	eErrNoData	= 3'b011,
	eErrHdMis	= 3'b100,
	eErrAdErr	= 3'b101,
	eErrTagInv	= 3'b110,
	eErrTerm	= 3'b111
    } PCIeHalMstError;

    typedef struct packed {
	logic [ 2:0]	attr;		// [127:125]
	logic		term;		// [	124] terminated by reset
	PCIeHalMstError error;		// [123:121]
	logic		cpl;		// [	120] req completed
	logic [12:0]	bcount;		// [119:107] remaining byte count
	logic [ 2:0]	tc;		// [106:104]
	logic [ 7:0]	tag;		// [103: 96]
	logic [15:0]	reqid;		// [ 95: 80]
	logic		ep;		// [	 79]
	PCIeHalCplCode	code;		// [ 78: 77]
	logic [12:0]	blen;		// [ 76: 64]
	logic [63:0]	addr;		// [ 63:  0]
    } PCIeHalMstCpl;
endpackage
  
  
  
  
