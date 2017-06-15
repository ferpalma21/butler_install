docker run --rm -p 9000:9000 --name coreNLP -t mycorenlp:mycorenlp &

sleep 5

wget --post-data 'The quick brown fox jumped over the lazy dog.' 'localhost:9000/?properties={"annotators":"tokenize,ssplit,pos,ner,depparse,openie","outputFormat":"json"}' -O -

docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" -e "xpack.security.enabled=false" --name elastic docker.elastic.co/elasticsearch/elasticsearch:5.4.1 &

docker run -p 5000:5000 --link elastic --link coreNLP:coreNLP -t --name butler_s butler_server:butler_server &

docker run --rm -it -p 3000:3000 --link butler_s --name butler_a butler_app:butler_app &