import React from 'react'
import { Card, CardBody, CardTitle } from 'reactstrap'

export default function Task(params) {
  console.log("Task params", params)
  let task = params.task
  return (
    <Card>
      <CardTitle>Task: {task.title}</CardTitle>
      <CardTitle>Assigned to: {task.assigned_user ? task.assigned_user : "Not assigned"}</CardTitle>
      <CardTitle>Status: {task.is_complete ? "Complete" : "Not Complete"}</CardTitle>
      <CardBody>
        <div>
          <p>Body: { task.body }</p>
        </div>
      </CardBody>
    </Card>
  )
}
