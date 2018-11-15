
// bram - Xilinx Block RAM interface (slave directions)
// 
// Allowed parameters:
//  MASTER_TYPE               - Master Type               (string default: <blank>) 
//  MEM_ECC                   - Mem Ecc                   (string default: <blank>) 
//  MEM_WIDTH                 - Mem Width                 (long) 
//  MEM_SIZE                  - Mem Size                  (long) 
//  READ_WRITE_MODE           - Read Write Mode           (string default: READ_WRITE)
module ip2bram #(
  parameter integer MEM_WIDTH = 64,
  parameter integer MEM_SIZE  = 1024
) (
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram EN" *)
  (* X_INTERFACE_PARAMETER = "MASTER_TYPE BRAM_CTRL,MEM_ECC None,READ_WRITE_MODE READ_WRITE" *)
  output bram_en, // Chip Enable Signal (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram DOUT" *)
  input [MEM_WIDTH-1:0] bram_dout, // Data Out Bus (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram DIN" *)
  output [MEM_WIDTH-1:0] bram_din, // Data In Bus (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram WE" *)
  output [MEM_WIDTH/8-1:0] bram_we, // Byte Enables (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram ADDR" *)
  output [$clog2(MEM_SIZE)-1:0] bram_addr, // Address Signal (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram CLK" *)
  output bram_clk, // Clock Signal (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram RST" *)
  output bram_rst // Reset Signal (required)
);

//  user logic here

endmodule
			
			