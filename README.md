# Tracker


HOMEWORK 7
Changes to make managers happen:
1) Added a boolean field to users that says if they are a manager or not.
   In a proper app this should be an id or mapping of some kind, for extensibility.
2) Added a manages table. This keeps track of the manager and worker for each manage.
   Used the example we saw in class to make the mappings of has_many Manages for the manager
3) Used the same example, but changed to has_one for the relationship of a users manager.
   This makes it simple for a user to find their own manager and managees.
4) Changed some logic so only a user's manager can assign a task. Any user can now
   assign a task as long as they are a manager, a change from ownership permissions.
5) Task report was a simple db query and new page, nothing big design wise.

Changes to make Time happen.
1) Added a new time block table. Initially made it too complicated, release it could be much simpler.
2) Time block has start time, stop time, and task_id. Task id is necessary because I didn't add a
   direct ownership of time blocks by tasks. Did it this way to simplify the design of tasks and
   because it didn't negatively impact how I was finding all the timeblocks (in terms of code,
   this would increase time complexity probably).
3) I decided to have all the time blocks display as permanent fields. This simplified the ui greatly.
4) Clicking new made a new time_block in the db assigned to this task and reloads the page to view it
5) The time displays as utc_time because time sanitation is overrated. If this was react I'd add a
   library for picking times but in plain html no thanks.
6) Update and Delete make Patch and Delete commands to the api then reload the page.

HOMEWORK 6
Design Choices and Whatnot.
Step 1: Fields of Classes

User:
  1) Email, obvious login choice on the modern web
  2) Name, something to identify them by
  3) Other fields unnecessary, auto id generated for us for unique representation

Tasks:
  1) Title: need a title/name for tasks
  2) Body: need a body/description to further explain the task
  3) Time Spent: How long people spent on this task, required
  4) Is Complete: Is the task done or not, required
  5) User: keep track of who created this task, only they can assign. It is conceivable
     that you'd want a different approach here for privileges for assigning tasks, but
     this makes the most logical sense to me.
  6) Assigned User: need to keep track of the user this task is assigned to. Both user
     fields are stored as belongs_to for easier association.

The remainder was mostly stitching together the scaffolding and adding some validation
where required. I chose to only let the assigned user to a task increment by 15 minutes
the time spent. The owner of a task is the only one who can assign it. A task does not
disappear on deletion of owner, I figured it should be kept around for posterity sake.
A future update will allow a hierarchy of permissions for assigning tasks based on groups.
