import React from 'react'
import Task from './task'

export default function Feed(params) {
  console.log("feed params", params)
  let tasks = _.map(params.tasks, (pp) => <Task key={pp.id} post={pp} />)
  return (
    <div>
      { tasks }
    </div>
  )
}
