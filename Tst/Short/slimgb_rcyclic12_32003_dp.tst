
  LIB "tst.lib";
  tst_init();
  ring MYRINGNAME=32003,(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12),dp;
  ideal MYIDEALNAME=x1+x2+x3,
x1*x2+x2*x3+x3*x4,
x1*x2*x3+x2*x3*x4+x3*x4*x5,
x1*x2*x3*x4+x2*x3*x4*x5+x3*x4*x5*x6,
x1*x2*x3*x4*x5+x2*x3*x4*x5*x6+x3*x4*x5*x6*x7,
x1*x2*x3*x4*x5*x6+x2*x3*x4*x5*x6*x7+x3*x4*x5*x6*x7*x8,
x1*x2*x3*x4*x5*x6*x7+x2*x3*x4*x5*x6*x7*x8+x3*x4*x5*x6*x7*x8*x9,
x1*x2*x3*x4*x5*x6*x7*x8+x2*x3*x4*x5*x6*x7*x8*x9+x3*x4*x5*x6*x7*x8*x9*x10,
x1*x2*x3*x4*x5*x6*x7*x8*x9+x2*x3*x4*x5*x6*x7*x8*x9*x10+x3*x4*x5*x6*x7*x8*x9*x10*x11,
x1*x2*x3*x4*x5*x6*x7*x8*x9*x10+x2*x3*x4*x5*x6*x7*x8*x9*x10*x11+x3*x4*x5*x6*x7*x8*x9*x10*x11*x12,
x1*x2*x3*x4*x5*x6*x7*x8*x9*x10*x11+x1*x3*x4*x5*x6*x7*x8*x9*x10*x11*x12+x2*x3*x4*x5*x6*x7*x8*x9*x10*x11*x12;
  option(redSB);
  slimgb(MYIDEALNAME);
  tst_status(1);$
  