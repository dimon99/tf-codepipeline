#!/bin/sh
##################################################################################
# Generates a diff summary of terraform plan json                                #
#                                                                                #
# The output is in "diff" format where the first character is the type of change #
# which can be easily used with markdown:                                        #
#                                                                                #
# ```diff                                                                        #
# + some.resource                                                                #
# - another.resource                                                             #
# ```                                                                            #

#                                                                                #
# USAGE                                                                          #
#                                                                                #
#   terraform-summary.sh < <terraform plan json file>                            #
#                                                                                #
# EXAMPLE                                                                        #
#                                                                                #
#   terraform plan -out=terraform.tfplan                                         #
#   terraform show -json | terraform-summary.sh                                  #
#                                                                                #
# 1) Filter for only resources that are changing                                 #
# 2) Generate a string for each resource with                                    #
#   a) "+", "-", or "-/+" depending on the type of change                        #
#   b) full address of the resource                                              #
#   c) a little message if the resource is being replaced                        #
# 3) Combine into a single string                                                #
##################################################################################

jq -r '.resource_changes
  | map(select(.change.actions != ["no-op"]))
  | map(
      . as $change
      | .change.actions
          | map(
              if . == "create" then
                "+"
              elif . == "delete" then
                "-"
              else
                null
              end
            )
          | join("/")
        + " "
        + $change.address
        + if ($change.change.actions | contains(["create"])) then
            " (new resource required)"
          else
            ""
          end
    )
  | join("\n")
  | if . == "" then "This plan does nothing." else . end'
