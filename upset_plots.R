cat("\014")
rm(list=ls())

{
  library(ComplexUpset)
  library(ggplot2)
}

set_size = function(w, h, factor=1.5) {
  s = 1 * factor
  options(
    repr.plot.width=w * s,
    repr.plot.height=h * s,
    repr.plot.res=100 / factor,
    jupyter.plot_mimetypes='image/png',
    jupyter.plot_scale=1
  )
}
#

#
set_size(8, 3)
#

upset(
  head(M2_BinaryMatrix, 10163286), colnames(M2_BinaryMatrix),
  n_intersections=5,
  min_degree = 2,
  sort_sets='descending',
  sort_intersections='descending',
  #
  set_sizes=(
    upset_set_size(position='right', geom = geom_bar(width = .9))
    + geom_text(aes(label=paste0(round((..count../nrow(M2_BinaryMatrix))*100))), hjust=1.2, stat='count', color='white')
    + expand_limits(y=1000)
    + ylab("")
    + theme(axis.text.x = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank()
    )
  ),
  #
  base_annotations=list(
        'Intersection size'=intersection_size(text_mapping=aes(label=paste0(round(
          !!get_size_mode('exclusive_intersection')/nrow(M2_BinaryMatrix) * 100
        ), '%')))
      + ylab("")
      + theme(axis.text.y = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank()
      ),
        'Intersection ratio'=intersection_ratio(text_mapping=aes(label=!!upset_text_percentage()))
    + ylab("")
    + theme(axis.text.y = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank()
    )
  ),
  #
  height_ratio=1.35,
  width_ratio=0.3,
  name="",
  wrap=TRUE,
  stripes='white', # c(alpha('grey90', 0.45), alpha('white', 0.3)),
  matrix = intersection_matrix(    
    geom=geom_point(
      shape='square',
      size=4
    ),
    segment=geom_segment(
      linetype='solid'
    ), 
    outline_color=list(
      active='darkorange3',
      inactive='grey70'
    )
  )
  #
) + labs(title = "", caption = "")
