Design Choices and Whatnot. Step 1: Fields of Classes

User:
Email, obvious login choice on the modern web
Name, something to identify them by
Password, for validation
Other fields unnecessary, auto id generated for us for unique representation

Tasks:
Title: need a title/name for tasks
Body: need a body/description to further explain the task
Time Spent: How long people spent on this task, required
Is Complete: Is the task done or not, required
User: keep track of who created this task, only they can assign. It is conceivable that you'd want a different approach here for privileges for assigning tasks, but this makes the most logical sense to me.
Assigned User: need to keep track of the user this task is assigned to. Both user fields are stored as belongs_to for easier association.
