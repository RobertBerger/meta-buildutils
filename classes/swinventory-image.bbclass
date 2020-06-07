## SPDX-License-Identifier: BSD-2-Clause
## Copyright (c) 2020, Konrad Weihmann

inherit swinventory

def swinventory_image_get_package(d, name, out):
    import os
    import json

    try:
        with open(os.path.join(d.getVar("SWINVENTORY_DEPLOY"), name + ".json")) as i:
            _in = json.load(i)
            out[name] = _in
            for _n in set(_in["depends"] + _in["rdepends"]):
                if _n not in out:
                    swinventory_image_get_package(d, _n, out)
    except FileNotFoundError:
        bb.warn("No swinventory for {} found".format(name))

python do_swinventory_image() {
    from oe.rootfs import image_list_installed_packages
    import json

    out = {}
    for k in image_list_installed_packages(d):
        swinventory_image_get_package(d, k, out)
    
    with open(d.expand("${DEPLOY_DIR_IMAGE}/${PN}-swinventory.json"), "w") as o:
        json.dump(out, o, sort_keys=True, indent=2)
}

ROOTFS_POSTPROCESS_COMMAND += " do_swinventory_image; "
