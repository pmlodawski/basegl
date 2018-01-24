

void main() {
  vec2      p     = local.xy ;
  sdf_shape shape = _main(p);
  int       sid   = shape.id;
  float     alpha = sdf_render(shape.density);

  float idMask              = sid == 0 ? 0.0 : 1.0;
  float componentFamilyID_r = float(floor(componentFamilyID + 0.5));
  float componentID_r       = float(floor(componentID + 0.5));

  if (drawBuffer == 0) {
      if (displayMode == 0) {
          gl_FragColor = vec4(toGamma(lch2rgb(shape.cd.rgb)), shape.cd.a * alpha);
      } else if (displayMode == 1) {
          vec3 col = distanceMeter(shape.density, 500.0 * zoomLevel, vec3(0.0,1.0,0.0), 500.0/zoomLevel);
          col = Uncharted2ToneMapping(col);
          gl_FragColor = vec4(pow(col, vec3(1./2.2)), 1.0 );
      } else if (displayMode == 2) {
          if (pointerEvents > 0.0) {
              vec3 cd = hsv2rgb(vec3(componentFamilyID_r/4.0, 1.0, 1.0));
              gl_FragColor = vec4(cd, idMask);
          } else {
              gl_FragColor = vec4(0.0);
          }
      } else if (displayMode == 3) {
          vec3 cd = hsv2rgb(vec3(componentID_r/4.0, 1.0, idMask));
          gl_FragColor = vec4(cd, idMask);
      } else if (displayMode == 4) {
          vec3 cd = hsv2rgb(vec3(float(sid)/20.0, 1.0, idMask));
          gl_FragColor = vec4(cd, idMask);
      } else if (displayMode == 5) {
          gl_FragColor = vec4(zIndex/100.0);
          gl_FragColor.a = idMask;
      }
  } else if (drawBuffer == 1) {
      if (pointerEvents > 0.0) {
          gl_FragColor = vec4(componentFamilyID_r,componentID_r,float(sid),idMask);
      } else {
          gl_FragColor = vec4(0.0);
      }
  }
}
