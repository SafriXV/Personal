#! /bin/bash
iconv -f utf8 -t eucjp | mecab | iconv -f eucjp -t utf8 | while IFS=$'\t,' read orig type relation u u u u stem kana1 kana2; do

kana=$(echo "$kana1" | kakasi -i utf8 -o utf8 -KH)
[[ $type != 助詞 || $orig ==  て  ]] && [[ $relation == 接続助詞 || $type == 助動詞  ]] && prepend="<Grammar Ending>" || prepend=""
[[ $stem == '*' || -z $stem  ]] && stem=$orig

edic=$(grep "^$stem " edict2.utf)
if [[ -z $edic  ]]; then
 ekfield=$(grep -E "(^|;)$stem[ ;(]" edict2.utf)
  particles=$(echo "$ekfield" | grep -vF '[')

 if [[ -z $particles  ]]; then
 edic=$(echo "$ekfield" | grep "$stem.*\[")
 [[ -z $edic  ]] && edic=$(grep "\[$stem[](]" edict2.utf)
else
 edic=$particles
fi
 [[ -z $edic  ]] && edic=$(grep "\[$kana[](]" edict2.utf)
 [[ -z $edic  ]] && edic=$(grep -E "(^|;)$stem[] (]" edict2.utf)
 [[ $type =~ 動詞  ]] && edic=$(echo "$edic" | grep -F $'(v\n(aux') #Filter verbs
fi

edic=$(echo "$edic" | sed 's|[^/]*/||;s|/[^/]*/$||;q')

echo -e "$orig \t $kana \t $prepend $edic"
done
