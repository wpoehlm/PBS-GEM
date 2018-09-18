echo "Sample" >> samples.temp
for i in *trim* ; do echo $i | awk -F '.' '{print $1}' >> samples.temp ; done

echo "Input Read Pairs" >> temp.1
for i in *trim* ; do cat $i | grep 'Input Read Pairs' | awk '{print $4}' >> temp.1 ; done

echo "Clean Read Pairs" >> temp.2
for i in *trim* ; do cat $i | grep 'Input Read Pairs' | awk '{print $7}' >> temp.2 ; done

echo "Concordant Unique Alignments" >> temp.3
for i in *hisat* ; do cat $i | grep concordantly | awk 'NR==2{print $1}' >> temp.3 ; done

echo "Overall Alignment Rate(%)" >> temp.4
for i in *hisat* ; do cat $i | grep overall | awk '{print $1}' | sed s/%// >> temp.4 ; done


paste samples.temp temp.1 temp.2 temp.3 temp.4 >> QC_report.tab

rm *temp*
