MATCH (u:User) WITH COLLECT(u) AS users
UNWIND users AS user
UNWIND users AS other
MATCH (user)-[:LIKES]->(common_media:Media)<-[:LIKES]-(other) WHERE ID(other) > ID(user)
WITH user, other, COLLECT(common_media) AS intersection

MATCH (user)-[:LIKES]->(user_media:Media)
WITH user, other, intersection, 
     COLLECT(user_media) AS s1

MATCH (other)-[:LIKES]->(other_media:Media)
WITH user,other,intersection, s1,
     COLLECT(other_media) AS s2

WITH user, other,(1.0 * SIZE(intersection)) / (SIZE(s1) + SIZE(s2) - SIZE(intersection)) AS jaccard

MERGE (user)-[:ISSIMILAR {similarity: jaccard}]->(other)
