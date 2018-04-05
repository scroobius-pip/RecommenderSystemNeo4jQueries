MATCH (m:Media) WITH COLLECT(m) AS media
UNWIND media AS medium
UNWIND media AS other
MATCH (medium)-[:ISTAG]->(common_tag:Tag)<-[:ISTAG]-(other) WHERE ID(other) > ID(medium)
WITH medium, other, COLLECT(common_tag) AS intersection

MATCH (medium)-[:ISTAG]->(media_tag:Tag)
WITH medium, other, intersection, 
     COLLECT(media_tag) AS s1

MATCH (other)-[:ISTAG]->(other_tag:Tag)
WITH medium,other,intersection, s1,
     COLLECT(other_tag) AS s2

WITH medium, other,(1.0 * SIZE(intersection)) / (SIZE(s1) + SIZE(s2) - SIZE(intersection)) AS jaccard

MERGE (medium)-[:ISSIMILAR {similarity: jaccard}]->(other)
