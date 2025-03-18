# 自动打包+加固+上传脚本
archive_configuration=enterprise
need_debugTool=true

echo "**默认企业版+需要Cocoadebug,可以直接回车"
echo "what's the configuration? (1: Debug 2: Test 3:Release)"
read configuration
if [[$configuration == D* || $configuration == d* || $configuration == 1]];then
archive_configuration=debug
elif [[$configuration == T* || $configuration == t* || $configuration == 2]];then
archive_configuration=enterprise
elif [[$configuration == R* || $configuration == r* || $configuration == 3]];then
archive_configuration=release
fi
echo "Do you need Cocoadebug? (y/n)"
read debugTool
if [[$debugTool == n]];then
need_debugTool=false
fi

#项目文件
workspace_path=$(dirname $(pwd))
#项目路径
project_name=XXX
target_name=XXX
project_path=${workspace_path}/${project_name}.xcodeproj
#导出
project_export_dir=${HOME}/Desktop
res_dir=${project_export_dir}/LOCALIPA/${target_name}
#输出配置
export_options_plist=${workspace_path}/bin/build-config/export-options-enterprise-dev.plist
export_xml_name=${workspace_path}bin/build-config/config-dev.xml
ipa_dir={res_dir}/debugIpa
release_note=debug

function restoreCocoaDebug {
#删除修改后的文件，并将原文件恢复
xcode_file=$project_path/project.project
xcode_file_copy=$project_path/project_backup.project
if [-f $xcode_file_copy];then
rm -rf $xcode_file
mv "$xcode_file_copy" "$xcode_file"
fi
}

function removeCocoaDebug{
#对原始文件进行备份，移除引用
xcode_file=$project path/project.pbxproj
xcode_file_copy=$project_path/project backup.pbxproj
if [ -f $xcode_file_copy ]; then
rm -rf $xcode_file_copy
fi
cp $xcode_file $xcode_file_copy
sed -i  '' '/.*"CocoaDebug.xcframework".*/d' $xcode_file
}

if [[ $archive_configuration == en* ]];
then
echo "Archive xxx——test :${SCHEME}"
export_options_plist=${workspace_path}/development/export-options-enterprise.plist
ipa_dir=${res_dir}/enterpriselpa
release_note=企业包
elif [[ $archive_configuration == re* ]];
then
echo "Archive xxx——release:${SCHEME}"
export_options_plist=${workspace_path}/development/export-options-enterprise-dis.plist
ipa_dir=${res_dir}/releaselpa
release_note=release
export_xml name=${workspace_path}/bin/build-config/config_dis.xml
else
echo "Archive xxx——debug: ${SCHEME}"
fi

if [[$need_debugTool == false]];
then
removeCocoaDebug
fi

ipa_archive_path=${ipa_dir}/${target_name}.xcarchive
ipa_path=${ipa_dir}/${target_name}.ipa
ipa_archive_path=${ipa_dir}/${target_name}.xcarchive
ipa_path=${ipa_dir}/${target_name}.ipa
shield_ipa_path=${ipa_dir}/${target_name}-shielded.ipa











