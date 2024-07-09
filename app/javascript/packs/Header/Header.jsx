import React from 'react';
import PropTypes from 'prop-types';
import Nav from './Nav';

function Header(props) {
  console.log(props)
  return (
    <>
        <Nav props={props} />
    </>
  )
}

	Header.propTypes = {
		loggedInUser: PropTypes.object,
  };
  
export default Header
