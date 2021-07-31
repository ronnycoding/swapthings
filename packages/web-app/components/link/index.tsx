import Link from 'next/link'
import styled from 'styled-components'

const StyledLink = styled.a`
  color: red;
`

function NavLink({ href, children, ...props }) {
  return (
    <Link href={href} passHref>
      <StyledLink {...props}>{children}</StyledLink>
    </Link>
  )
}

export default NavLink
