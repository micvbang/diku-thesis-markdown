
Figures and stuff {#sec:figures-and-stuff}
=================
In this section, we introduce the background knowledge required to understand the rest of this report. We begin with the introduction of global selections. We conclude the chapter with an introduction of the system level performance techniques that we hope can improve the performance of global selections, indexing, and parallelism.

Figures { #sec:figures-and-stuff:figures }
-------

These are some side-by-side figures.

\begin{figure}[!t]
    \centering
    \begin{minipage}{.5\textwidth}
        \hspace{-1.2in}
        \centering
        \includegraphics[width=1.4\linewidth]{figures/uk_hotels.pdf} \\
        \caption*{(a)}
    \end{minipage}%
    \begin{minipage}{0.5\textwidth}
        \hspace{1.3in}
        \centering
        \includegraphics[width=1.4\linewidth]{figures/uk_hotels_filtered.pdf} \\
        \caption*{(b)}
    \end{minipage}
    \caption{\textbf{(a)} Raw hotel (blue) and animal park (pink) data from OpenStreetMap project. \textbf{(b)} Result of global selection (shown on Listing \ref{lst:running-example}) on the same data.}
    \label{fig:uk-hotels-global-selection}
\end{figure}

\begin{figure}[!t]
    \centering
    \begin{minipage}{.5\textwidth}
        \hspace{-1.2in}
        \centering
        \includegraphics[width=1.4\linewidth]{figures/uk_hotels_filtered_and_all_london.pdf} \\
        \caption*{(a)}
    \end{minipage}%
    \begin{minipage}{0.5\textwidth}
        \hspace{1.3in}
        \centering
        \includegraphics[width=1.4\linewidth]{figures/uk_hotels_filtered_london.pdf} \\
        \caption*{(b)}
    \end{minipage}
    \caption{\textbf{(a)} Raw hotel (blue) and animal park (pink) data from OpenStreetMap project, zoomed on the London area. \textbf{(b)} Result of global selection (shown on Listing \ref{lst:running-example}) on the same data.}
    \label{fig:uk-hotels-global-selection-london}
\end{figure}



![This is a single figure](figures/conflict_derivation_conflict_resolution.pdf){#fig:conflict-derivation-conflict-resolution}


#### Listing {#lst:figures-and-stuff:listing}
This is a listing

~~~~~ { #lst:running-example .sql .numberLines }
SELECT osmid, name, lon, lat
FROM uk_hotels WITH KEY osmid
ITERATE OVER RANGE FROM 18 TO 1 AS zoom
          -- Prioritize hotels with animal parks nearby
WEIGH BY (999999 - distance_to_closest_animal_park(geom))
SUBJECT TO
  -- Remove hotels not close to public transport
  MAP BY (SELECT array_agg(osmid) ids
          FROM uk_hotels
          WHERE osmid NOT IN (
              SELECT h.osmid
              FROM uk_hotels h, uk_transport p
          	  WHERE ST_DWithin(h.geom, p.geom, 1000))
  )
  LIMIT 0
AND
  -- Ensure uncluttered map, at most 3 hotels per tile
  MAP BY (SELECT array_agg(osmid) ids
          FROM uk_hotels
          GROUP BY TileOnZoomLevel(geom, zoom)
  )
  LIMIT 3
~~~~~
Listing: Global selection formulation of query for finding hotels that are within 1 km of public transportation, preferring hotels that are closer to animal parks, tiling hotels according to zoom level, allowing at most three hotels per zoom level-appropriate tile.


~~~~~ { .python #lst:haversine-distance }
def haversine_distance(p1, p2):
    diff_lat = p2.lat - p1.lat
    diff_lon = p2.lon - p1.lon

    a = (sin(diff_lat/2)^2 +
         cos(p1.lat) * cos(p2.lat) +
         sin(diff_lon/2)^2)
    c = 2 * atan2(sqrt(a, sqrt(1-a))
    return 6371000 * c
~~~~~
Listing: A Python implementation of the Haversine formula, for calculating the distance between two geospatial points.

#### Table

This is a simple table.

\begin{table}[!t]
\centering
\caption{The factor of difference between the running time of the density constraint using Python and Scala }
\label{tbl:python-overhead}
\begin{tabular}{@{}rrrc@{}}
\toprule
Tuples    &  Scala     & Python  & Factor of difference ~\\ \midrule
  488k    &   1.25     &  3.32   &  2.65 ~\\
  976k    &   1.13     &  3.58   &  3.17 ~\\
  1.9m    &   1.29     &  4.28   &  3.32 ~\\
  3.9m    &   2.14     &  8.44   &  3.95 ~\\
  7.8m    &   3.37     &  13.84  &  4.10 ~\\
  15.6m   &   5.95     &  25.31  &  4.25 ~\\
  31.2m   &   12.01    &  49.25  &  4.10 ~\\
  62.4m   &   22.30    &  96.71  &  4.34
\end{tabular}
\end{table}


This is a more fancy table.

\begin{table}[]
\caption{Summary of traits implemented by each of the systems considered}
\label{tbl:systems-summary}
\begin{tabular}{@{}llp{3cm}p{3.3cm}@{}}
\toprule
System     & Partitioning                      & Parallelism                                    & Indexing                                    ~\\ \midrule
Greenplum  & \cellcolor{yellow!25}Non-spatial  & \cellcolor{green!25}Distributed                & \cellcolor{green!25}Spatial/R-tree          ~\\
Hadoop-GIS & \cellcolor{green!25}Spatial       & \cellcolor{green!25}Distributed                & \cellcolor{green!25}Spatial/R-tree          ~\\
Oracle     & \cellcolor{yellow!25}Non-spatial  & \cellcolor{green!25}Distributed                & \cellcolor{green!25}Spatial/R-tree/Quadtree ~\\
PostgreSQL & \cellcolor{yellow!25}Non-spatial  & \cellcolor{yellow!25}Restricted single-machine & \cellcolor{green!25}Spatial/R-tree          ~\\
Simba      & \cellcolor{green!25}Spatial       & \cellcolor{green!25}Distributed                & \cellcolor{green!25}Spatial/R-tree
\end{tabular}
\end{table}

#### References {#sec:figures-and-stuff:references}

We reference the literature [@wiki:set_cover]. \\
Reference literature by page [@setmulticover_exact, p. 729-730]. \\
By page and multiple refs[@setmulticover_exact, p. 729-730;@wiki:set_cover]. \\

We make a reference to lines 7-14 in @lst:running-example. \\

This is a reference to @fig:conflict-derivation-conflict-resolution. \\

Reference section @sec:figures-and-stuff:references. \\

Reference chapter Chapter [-@sec:figures-and-stuff]. \\

Reference appendix @sec:appendix:a

#### Formatting and stuff

Math $\frac{10^{6}}{10^{5}} = 10$

*bold* _italic_ `code`

1. list
2. item2
3. item3


This is a line.

This is one kind of line break. \\

This is another kind of line break.
