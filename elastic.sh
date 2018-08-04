#!/bin/bash
for filename in /home/ada/Documents/elastic_data/*; do
   curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/all_states/doc/_bulk?pretty' --data-binary @$filename
done
