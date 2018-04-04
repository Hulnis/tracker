import React from 'react'
import Task from './task'

export default function Feed(params) {
  console.log("feed params", params)
  let tasks = _.map(params.tasks, (t) => <Task key={t.id} task={t} />)
  console.log("tasks", tasks)
  return (
    <div>
      { tasks }
    </div>
  )
}
