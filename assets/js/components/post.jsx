import React from 'react'
import { Card, CardBody } from 'reactstrap'

export default function Post(params) {
  let post = params.post
  return (
    <Card>
      <CardBody>
        <div>
          <p>Posted by <b>{ post.user.name }</b></p>
          <p>{ post.body }</p>
        </div>
      </CardBody>
    </Card>
  )
}
