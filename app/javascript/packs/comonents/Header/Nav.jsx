import React from 'react'

function Nav() {
  return (
		<nav>
			<ul>
				<li>
					<Link to='/'>HOME</Link>
				</li>
				<li>
					<Link to={`/users/${userId}`}>Privacy</Link>
				</li>
				<li>
					<Link to={`/users/${userId}/posts`}>My Profile</Link>
				</li>

				<li>
					{localStorage.getItem("token") ? (
						<Link to='/logout'>Logout</Link>
					) : (
						<Link to='/login'>Login</Link>
					)}
				</li>
			</ul>
		</nav>
	);
}

export default Nav