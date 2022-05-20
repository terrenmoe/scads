module fillet(r) {
   offset(r = -r) {
     offset(delta = r) {
       children();
     }
   }
}
