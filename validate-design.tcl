
package require json

namespace eval asterism {

    set script_path [info script]
    set script_dir [file dirname ${script_path}]
    set DEFAULT_CONFIG_FILE ${script_dir}/config.json

    proc set_intf_properties {inst corr} {
        dict for {intf_name properties} ${corr} {
            dict for {intf_property mod_property} ${properties} {
                set value [get_property CONFIG.${mod_property} ${inst}]
                set_property CONFIG.${intf_property} ${value} [get_bd_intf_pins ${inst}/${intf_name}]
                puts "INFO: ${intf_name}.${intf_property} <- ${mod_property} = ${value} (${inst})"
            }    
        }    
    }

    proc get_bd_ips {{hier /}} {
        set ips [list]
        foreach cell [get_bd_cells ${hier}*] {
            switch [get_property TYPE ${cell}] {
            "ip" {lappend ips ${cell}}
            "hier" {lappend ips [get_bd_ips ${cell}/]}
            }   
        }
        return ${ips}
    }

    proc validate_design {{config_file ""}} {
        if {${config_file} eq ""} {
            set config_file ${::asterism::DEFAULT_CONFIG_FILE}
        }
        puts "INFO: load ${config_file}"
        if [file exists ${config_file}] {
            set fId [open ${config_file} r]
            set json [read ${fId}]
            close ${fId}
        } else {
            puts "ERROR: \"${config_file}\" is not found" 
            exit 1
        }
        set config [::json::json2dict ${json}]
        foreach inst [get_bd_ips] {
            set vlnv [get_property VLNV ${inst}]
            set module [lindex [split ${vlnv} :] 2]
            if [dict exists ${config} ${module}] {
                set corr [dict get ${config} ${module}]
                set_intf_properties ${inst} ${corr}
            }
        }
    }
}


::asterism::validate_design
validate_bd_design


