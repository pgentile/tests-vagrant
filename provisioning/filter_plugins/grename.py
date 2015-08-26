def gre_name(names, prefix):
    sorted_names = sorted(names)
    return "{}-{}-{}".format(prefix, *sorted_names)


class FilterModule(object):

    def filters(self):
        return dict(
            gre_name=gre_name,
        )
