# Tracker
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
