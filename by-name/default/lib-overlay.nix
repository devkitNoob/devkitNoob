finalLib: prevLib: let
  prevMaintainers = prevLib.maintainers;
in {
  maintainers =
    prevMaintainers
    // builtins.mapAttrs (handle: value:
      if prevMaintainers ? ${handle} && prevMaintainers.${handle} != handle
      then finalLib.warn "${handle} (${value.name}) is already a differing maintainer (${prevMaintainers.${handle}.name})" prevMaintainers.${handle}
      else value) (import ./_maintainer-list.nix);
}
