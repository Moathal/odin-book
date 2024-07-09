import React from 'react';
import PropTypes from 'prop-types';

function Nav({ props }) {
	console.log(`props: ${props}`);
  return (
		<nav>
			<ul>
				<li>
					<a href='/'>HOME</a>
				</li>
				<li>
					<a href={`/users/${props.userId}`} data-turbo-frame='main'>
						Privacy
					</a>
				</li>
				<li>
					<a
						href={`/users/${props.userId}/posts`}
						data-turbo-frame='main'>
						My Profile
					</a>
				</li>

				<li>
					{props.userId ? (
						<a
							href='/users/sign_out'
							data-turbo-method='delete'
							data-turbo-frame='main'>
							Logout
						</a>
					) : (
						<a href='/users/sign_in' data-turbo-frame='main'>
							Login
						</a>
					)}
				</li>
			</ul>
		</nav>
	);
}

	Nav.propTypes = {
		props: PropTypes.object
	};

export default Nav