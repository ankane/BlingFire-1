spm_export_vocab --model spiece.model --output spiece.model.exportvocab.txt --output_format vocab

cat spiece.model.exportvocab.txt | awk 'BEGIN {FS="\t"} NF == 2 { if (NR > 1) { print $1 "\tWORD_ID_" NR-1 "\t" ($2 == 0 ? "-0.00001" : $2); }  print "WORD_ID_" NR " " NR > "tagset.txt"; }' > pos.dict.utf8

zip pos.dict.utf8.zip pos.dict.utf8

python ./generate_charmap.py > charmap.utf8
