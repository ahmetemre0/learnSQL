SELECT id, name, joined_at, leaved_at FROM Members
WHERE still_member = 0;

-- As you can see, some of the joining dates are after the leaving dates.
-- This is a mistake in the data. We need to fix this.
-- We need to swap the joining and leaving dates for these rows.

-- Also there is a typo in the column name. It should be "left_at" instead of "leaved_at".
-- We need to fix this as well.

-- Also, the column "still_member" is not needed. We need to drop this column. 
-- We can check the membership status by looking at the "left_at" column.

-- Please fix these issues and save the corrected table as "Members_corrected".

-- Also, we need to calculate each post's total number of likes, dislikes, and comments.
-- Please calculate these values and save them as "Posts_with_stats_{date}" in the database.
-- Please replace "{date}" with the current date in the format "YYYY-MM-DD".

