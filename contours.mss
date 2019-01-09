@contour: #e8b898;

#contours-100 {
		line-color: @contour;
		[zoom = 12] { line-width: 0.8; }
		[zoom = 13] { line-width: 0.9; }
		[zoom >= 14] { 
				line-width: 1.0;
				line-smooth: 0.5;
				text-face-name: @book-fonts;
				text-size: 11;
				text-fill: @contour;
				text-halo-radius: 1;
				text-halo-fill: rgba(255,255,255,1);
				text-halo-comp-op: soft-light;
				text-placement: line;
				text-name: [ele];
				text-max-char-angle-delta: 10;
				text-label-position-tolerance: 100;
				text-min-path-length: 200;
				text-spacing: 200;
				text-upright: left;
		}				
}

#contours-50b {
		line-color: @contour;
		[zoom >= 14] { 
				line-width: 0.8;
				line-smooth: 0.5;
				text-face-name: @book-fonts;
				text-size: 11;
				text-fill: @contour;
				text-halo-radius: 1;
				text-halo-fill: rgba(255,255,255,1);
				text-halo-comp-op: soft-light;
				text-placement: line;
				text-name: [ele];
				text-max-char-angle-delta: 10;
				text-label-position-tolerance: 100;
				text-min-path-length: 200;
				text-spacing: 200;
				text-upright: left;					
		}
}

#contours-50a {
		line-color: @contour;
		[zoom = 12] { 
				line-width: 0.6;
				line-smooth: 0.5;
				text-face-name: @book-fonts;
				text-size: 11;
				text-fill: @contour;
				text-halo-radius: 1;
				text-halo-fill: rgba(255,255,255,1);
				text-halo-comp-op: soft-light;
				text-placement: line;
				text-name: [ele];
				text-max-char-angle-delta: 10;
				text-label-position-tolerance: 100;
				text-min-path-length: 200;
				text-spacing: 200;
				text-upright: left;					
		}
}

#contours-20 {
		line-color: @contour;
		[zoom = 13] { 
				line-width: 0.7;
				line-smooth: 0.5;
		}
}

#contours-10 {
		line-color: @contour;
		[zoom >= 14] { 
				line-width: 0.6;
				line-smooth: 0.5;
				text-face-name: @book-fonts;
				text-size: 11;
				text-fill: @contour;
				text-halo-radius: 1;
				text-halo-fill: rgba(255,255,255,1);
				text-halo-comp-op: soft-light;
				text-placement: line;
				text-name: [ele];
				text-max-char-angle-delta: 10;
				text-label-position-tolerance: 100;
				text-min-path-length: 300;
				text-spacing: 800;
				text-upright: left;					
		}
}

#hillshade-5000 {
    raster-opacity: 0.9;
    raster-scaling: bilinear;
    raster-comp-op: grain-merge;
}

#hillshade-1000 {
    raster-opacity: 0.9;
    raster-scaling: bilinear;
    raster-comp-op: grain-merge;
}

#hillshade-500 {
    raster-opacity: 0.9;
    raster-scaling: bilinear;
    raster-comp-op: grain-merge;
}

#hillshade-90 {
    raster-opacity: 0.83;
    raster-scaling: bilinear;
    raster-comp-op: grain-merge;
}

#relief-5000 {
	raster-opacity: 0.6;
	raster-scaling: bilinear;
}

#relief-500 {
	raster-opacity: 0.6;
	raster-scaling: bilinear;
}
