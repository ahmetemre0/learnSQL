CREATE TABLE IF NOT EXISTS `Members` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL,
  `email` TEXT NOT NULL,
  `username` TEXT NOT NULL,
  `joined_at` TEXT NOT NULL,
  `still_member` INTEGER NOT NULL,
  `leaved_at` TEXT
);

CREATE TABLE IF NOT EXISTS `Posts` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` TEXT NOT NULL,
  `content` TEXT NOT NULL,
  `created_at` TEXT NOT NULL,
  `member_id` INTEGER NOT NULL,
  FOREIGN KEY(`member_id`) REFERENCES `Members`(`id`)
);

CREATE TABLE IF NOT EXISTS `Comments` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `content` TEXT NOT NULL,
  `created_at` TEXT NOT NULL,
  `member_id` INTEGER NOT NULL,
  `post_id` INTEGER NOT NULL,
  FOREIGN KEY(`member_id`) REFERENCES `Members`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE IF NOT EXISTS `Likes` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `member_id` INTEGER NOT NULL,
  `post_id` INTEGER NOT NULL,
  FOREIGN KEY(`member_id`) REFERENCES `Members`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE IF NOT EXISTS `Dislikes` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `member_id` INTEGER NOT NULL,
  `post_id` INTEGER NOT NULL,
  FOREIGN KEY(`member_id`) REFERENCES `Members`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE IF NOT EXISTS `Follows` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `follower_id` INTEGER NOT NULL,
  `followed_id` INTEGER NOT NULL,
  FOREIGN KEY(`follower_id`) REFERENCES `Members`(`id`),
  FOREIGN KEY(`followed_id`) REFERENCES `Members`(`id`)
);