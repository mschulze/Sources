#include <poly_wrap.h>
#include <boost/python.hpp>
#include "mod2.h"
#include "Poly.h"
#include "ring_wrap.h"
#include "intvec_wrap.h"
using boost::python::self;
boost::python::str Poly_as_str(const Poly& p)
{
  using boost::python::str;
  //ring r=p.getRing();
 
  char* out=p.c_string();
  return boost::python::str(out,strlen(out));
}
static Ring Poly_get_Ring(const Poly & p){
  return p.getRing();
}
void export_poly()
{
   boost::python::class_<Poly>("polynomial")
    .def("ring",Poly_get_Ring)
    .def(boost::python::init <int>())
    .def(boost::python::init <Poly>())
//    .def(boost::python::init <std::vector<int> >())
    .def(boost::python::init <Number>())
    .def(boost::python::init <better_intvec> ())
    .def("__str__", Poly_as_str)
    .def("__iter__", boost::python::iterator<Poly>())
    //read monomials (only) from string
    .def(boost::python::init <const char* >())
    
    .def(-self)
    .def(self*=self)
    .def(self+=self)
    //    .def(self-=self)
    //.def(self/=self)
    //.def(self==self)
    .def(self+self)
    .def(self*=Number())
    .def(self*Number())
    .def(self+Number())
    .def(self+=Number())
    .def(self*=Number())
    .def(self*self);
}


