def include_from_list(values, *included):
    return [v for v in values if v in included]


def exclude_from_list(values, *excluded):
    return [v for v in values if v not in excluded]


class FilterModule(object):

    def filters(self):
        return dict(
            include=include_from_list,
            exclude=exclude_from_list,
        )
