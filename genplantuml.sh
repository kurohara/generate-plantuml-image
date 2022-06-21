#!/bin/bash
awk \
          '
          BEGIN {count = 0;}
          /[ ]*```plantuml[ ]*$/ { 
            inuml = 1; 
            count = count + 1; 
            fname = "tmp" count ".puml"; 
            imgname = "fig" count ".png";
          }
          /[ ]*```[ ]*$/ { 
            if (inuml > 0) inuml = -1;
          }
          {
            if (inuml > 1) print >> fname; 
            if (inuml == 1) print "![fig](" imgname ")";
            if (inuml == 0) print;
            if (inuml == 1) inuml = 2;
            if (inuml == -1) inuml = 0;
          }
         ' < README.md > .github/README.md

for fn in `ls tmp*.puml`;do
    imgname=`echo $fn | sed -e 's/^tmp/fig/' -e 's/puml$/png/'`;
    echo "$fn ==> $imgname" ;
    npx node-plantuml generate $fn -p -o .github/$imgname;
done

rm tmp*.puml
