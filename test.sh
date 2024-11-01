# Definindo um array com 4 elementos
meu_array=("/tmp/" "/" "/usr/" "/dev/")
for elemento in "${meu_array[@]}"; do
    ls "$elemento"
done
