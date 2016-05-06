def include_from_list(values, *included):
    return [v for v in values if v in included]


def exclude_from_list(values, *excluded):
    return [v for v in values if v not in excluded]


def hostvars_for_group(hostvars, group):
    return [hostvars[hostname] for hostname in group]


def dict_values(d):
    return d.values()


class FilterModule(object):

    def filters(self):
        return dict(
            include=include_from_list,
            exclude=exclude_from_list,
            hostvars_for_group=hostvars_for_group,
            dict_values=dict_values,
            to_list=list,
        )
