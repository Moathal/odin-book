import React from 'react'

function Post({props}) {
  const post = props;
  return (
		<div>
			<h3>{post.user_id}</h3>
			<div dangerouslySetInnerHTML={{ __html: post.text_html }} />
		</div>
	);
}

export default Post