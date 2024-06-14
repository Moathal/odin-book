import React from 'react'

function Nav({loggedInUser}) {
  return (
		<nav>
			<ul>
				<li>
					<a href='/'>HOME</a>
				</li>
				<li>
					<a
						href={`/users/${loggedInUser.id}`}
						data-turbo-frame='react_component'>
						Privacy
					</a>
				</li>
				<li>
					<a
						href={`/users/${loggedInUser.id}/posts`}
						data-turbo-frame='react_component'>
						My Profile
					</a>
				</li>

				<li>
					{loggedInUser ? (
						<a
							href='/users/sign_out'
							data-turbo-method='delete'
							data-turbo-frame='react_component'>
							Logout
						</a>
					) : (
						<a href='/users/sign_in' data-turbo-frame='react_component'>
							Login
						</a>
					)}
				</li>
			</ul>
		</nav>
	);
}

export default Nav