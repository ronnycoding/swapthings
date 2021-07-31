import Navbar from '../navbar'
import Footer from '../footer'

const Page = ({ children }) => {
  return (
    <div>
      <Navbar />
      <main>{children}</main>
      <Footer />
    </div>
  )
}

export default Page
