#!/bin/sh
ctr=$(buildah from ubi9/ubi-minimal)
wrkdir=/usr/local/bin
version=$1
buildah copy $ctr hellogo $wrkdir
buildah run $ctr chmod a+x $wrkdir/hellogo
buildah run $ctr chgrp -R 0 $wrkdir 
buildah run $ctr chmod -R g=u $wrkdir
buildah config --workingdir $wrkdir $ctr
buildah config --cmd $wrkdir/hellogo $ctr
buildah config --entrypoint $wrkdir/hellogo $ctr
buildah commit $ctr hellogo
buildah tag hellogo hellogo:$version
