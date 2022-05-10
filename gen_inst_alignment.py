import sys, os, re

def gen_inst_alignment(ifile='text'):
    row = []
    path ='temp'
    if os.path.isdir(path)=False:
        os.mkdir(path)
    ofile = os.path.join(path, ofile)
    
    with open (ofile, 'w') as fw:
         with open (ifile, 'r') as f:
             for line in f:
                 row_strip = re.sub(r"[n\t\s]*, "", line)
                 row=re.split("[)(]", row_strip)
                 if len(row_strip) !=0:
                    if '//' in line:
                        fw.write("{}".format(line))
                    elif '.' == row_strip[0]:
                         if(len(row)) ==3:
                             fw.write("\t\t{0[0]:<50}{m0}{0[1]:40}{m1}{0[2]:<40}\n ".format(row,m0="(", m1=")" ))
                         elif len(row) ==2:
                             fw.write("\t\t{0[0]:<50}{m0}{0[1]:<40} {m1}".format(row, m0="(", m1=")"))
                         else:
                             print ("INFO: INVALID", row)
                     elif 'u_' in row[0][1:2]:
                          fw.write("\t{}" .format(line))
                     else:
                         fw.write("{}" .format(line))
                 else:
                     fw.write("{}" .format(line))
                                    
                                    
if __name__=="__main__":
    gen_inst_alingmnet(ifile='aaa.sv')                              
      
