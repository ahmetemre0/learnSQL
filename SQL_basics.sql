-- Retrieve only the columns 'id', 'name', 'joined_at', 'leaved_at' from 'Members' table

SELECT id, name, joined_at, leaved_at FROM Members;

-- Retrieve only the columns 'id', 'title', 'content', 'created_at' from 'Posts' table

SELECT id, title, content, created_at FROM Posts;

-- Retrieve all data from 'Members' table

SELECT * FROM Members;

-- Retrieve all data from 'Posts' table

SELECT * FROM Posts;

-- Retrieve only the columns 'id', 'name', 'joined_at', 'leaved_at' from 'Members' table where member is still active

SELECT id, name, joined_at, leaved_at FROM Members WHERE still_member = 1;

-- Retrieve only the columns 'id', 'name', 'joined_at', 'leaved_at' from 'Members' table where member is not active

SELECT id, name, joined_at, leaved_at FROM Members WHERE still_member = 0;
-- OR
SELECT id, name, joined_at, leaved_at FROM Members WHERE NOT still_member = 1;

-- Retrieve only the columns 'id', 'name', 'joined_at' from 'Members' table where member is still active and joined after 2020-03-01

SELECT id, name, joined_at FROM Members WHERE still_member = 1 AND joined_at > '2020-03-01';

-- Retrieve only the columns 'name', 'title', 'content' from 'Members' and 'Posts' table

SELECT Members.name, Posts.title, Posts.content FROM Members
JOIN Posts ON Members.id = Posts.member_id;

-- Retrieve only the columns 'name', 'title', 'content' from 'Members' and 'Posts' table where member is still active and has at least 1 post

SELECT Members.name, Posts.title, Posts.content FROM Members
JOIN Posts ON Members.id = Posts.member_id
WHERE Members.still_member = 1;

-- Retrieve only the columns follower name, followed name from 'Follows' and 'Members' table

SELECT Members.name AS follower_name, Members_1.name AS followed_name FROM Follows
JOIN Members ON Follows.follower_id = Members.id
JOIN Members AS Members_1 ON Follows.followed_id = Members_1.id;

-- Retrieve only the columns 'name', posts count from 'Members' table where member is still active and has more than 1 post

SELECT Members.name, COUNT(Posts.id) AS posts_count FROM Members
JOIN Posts ON Members.id = Posts.member_id
WHERE Members.still_member = 1
GROUP BY Members.id
HAVING posts_count > 1;

-- Retrieve only the columns 'id', 'title', 'content', 'created_at', like count from 'Posts' table where post has less than 2 likes

SELECT Posts.id, Posts.title, Posts.content, Posts.created_at, COUNT(Likes.id) FROM Posts
LEFT JOIN Likes ON Posts.id = Likes.post_id
GROUP BY Posts.id
HAVING COUNT(Likes.id) < 2;

-- Retrieve only the columns 'id', 'title', 'content', 'created_at', like count, dislike count from 'Posts' table where post has more likes than dislikes

SELECT Posts.id, Posts.title, Posts.content, Posts.created_at, 
(SELECT COUNT(Likes.id) FROM Likes WHERE Posts.id = Likes.post_id),
(SELECT COUNT(Dislikes.id) FROM Dislikes WHERE Posts.id = Dislikes.post_id)
FROM Posts
WHERE (SELECT COUNT(Likes.id) FROM Likes WHERE Posts.id = Likes.post_id) > (SELECT COUNT(Dislikes.id) FROM Dislikes WHERE Posts.id = Dislikes.post_id);

-- Retrieve only the columns 'id', 'title', 'content', 'created_at', like count, dislike count from 'Posts' table where post has less than 2 likes or more than 1 dislike

SELECT Posts.id, Posts.title, Posts.content, Posts.created_at,
(SELECT COUNT(Likes.id) FROM Likes WHERE Posts.id = Likes.post_id) AS like_count,
(SELECT COUNT(Dislikes.id) FROM Dislikes WHERE Posts.id = Dislikes.post_id) AS dislike_count
FROM Posts
WHERE like_count < 2 OR dislike_count > 1;

-- Retrieve only the columns 'id', 'title', 'content', difference between likes and dislikes from 'Posts' table where post has more likes than dislikes

WITH like_counts AS (
SELECT Posts.id, COUNT(Likes.id) AS like_count FROM Posts
JOIN Likes ON Posts.id = Likes.post_id
GROUP BY Posts.id
),
dislike_counts AS (
SELECT Posts.id, COUNT(Dislikes.id) AS dislike_count FROM Posts
JOIN Dislikes ON Posts.id = Dislikes.post_id
GROUP BY Posts.id
)
SELECT Posts.id, Posts.title, Posts.content, like_count - dislike_count AS popularity FROM Posts
JOIN like_counts ON Posts.id = like_counts.id
JOIN dislike_counts ON Posts.id = dislike_counts.id
WHERE like_count > dislike_count;

-- Retrieve only the columns 'id', 'title', 'content', difference between likes and dislikes as 'popularity' from 'Posts' table where post has more likes than dislikes

WITH like_counts AS (
SELECT Posts.id, COUNT(Likes.id) AS like_count FROM Posts
JOIN Likes ON Posts.id = Likes.post_id
GROUP BY Posts.id
),
dislike_counts AS (
SELECT Posts.id, COUNT(Dislikes.id) AS dislike_count FROM Posts
JOIN Dislikes ON Posts.id = Dislikes.post_id
GROUP BY Posts.id
)
SELECT Posts.id, Posts.title, Posts.content, like_count - dislike_count AS popularity FROM Posts
JOIN like_counts ON Posts.id = like_counts.id
JOIN dislike_counts ON Posts.id = dislike_counts.id
WHERE like_count > dislike_count
ORDER BY popularity DESC;
