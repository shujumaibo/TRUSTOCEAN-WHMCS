{* jsApplicationLibary *}
<script src="/modules/servers/TRUSTOCEANSSL/assets/js/adminarea.js" type='application/javascript'></script>
{* admin area style sheets*}
<link rel="stylesheet" href="/modules/servers/TRUSTOCEANSSL/assets/css/adminarea.css">

<ul class="nav nav-tabs admin-tabs" role="tablist" style="padding: 5px 10px;background-color: #000000; border-radius: 3px;">
    <li>
        <img src="/modules/servers/TRUSTOCEANSSL/assets/img/trustocean-seal.svg" height="20px;">
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top active" href="#tabOrder" role="tab" data-toggle="tab" id="tabLink1" data-tab-id="1" aria-expanded="true">订单概览</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabDomains" role="tab" data-toggle="tab" id="tabLink7" data-tab-id="7" aria-expanded="true">域名列表</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabDCV" role="tab" data-toggle="tab" id="tabLink2" data-tab-id="2" aria-expanded="true">域名验证</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabOrg" role="tab" data-toggle="tab" id="tabLink3" data-tab-id="3" aria-expanded="true">组织验证</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabCsr" role="tab" data-toggle="tab" id="tabLink4" data-tab-id="4" aria-expanded="true">CSR</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabCert" role="tab" data-toggle="tab" id="tabLink5" data-tab-id="5" aria-expanded="true">证书</a>
    </li>
    <li>
        <a style="border-radius: 0px; background-color: black; border: none; color: #ffffff;" class="tab-top" href="#tabChains" role="tab" data-toggle="tab" id="tabLink6" data-tab-id="6" aria-expanded="true">证书链</a>
    </li>
</ul>
<div class="tab-content admin-tabs" style="background-color: #ffffff;">
    <div class="tab-pane active" id="tabOrder">
        <table class="datatable to-table" width="100%">
            <tbody>
                <tr>
                    <td colspan="2">
                        <a class="btn btn-default btn-sm" onclick="TRUSTOCEANSSLModelApp.runModuleCommand('setOrderAsRenewal', {})">设为续费订单</a>
                        <a class="btn btn-default btn-sm" onclick="TRUSTOCEANSSLModelApp.runModuleCommand('syncOrderInformation', {})">同步订单信息</a>
                        <a class="btn btn-default btn-sm" onclick="TRUSTOCEANSSLModelApp.runModuleCommand('cancelAndRefundOrder', {})">申请退款</a>
                        <a class="btn btn-default btn-sm" onclick="jQuery('#modalModuleTrustOceanRevocationSSL').modal('show')">吊销证书</a>
                        <a class="btn btn-default btn-sm" onclick="TRUSTOCEANSSLModelApp.runModuleCommand('retryDcvProcess', {})">重新验证域名</a>
                        <a class="btn btn-default btn-sm">重发签发通知</a>
                        <a class="btn btn-default btn-sm">重发电话验证邮件</a>
                        <div id="TrustOceanSSLmodelworking"><img src="images/loader.gif"> &nbsp; API Working...</div>
                    </td>
                </tr>
                <tr>
                    <td width="150px;">证书类型</td>
                    <td>{$certModel->getName()}</td>
                </tr>
                <tr>
                    <td width="150px;">状态</td>
                    <td>{$certModel->getStatus()}</td>
                </tr>
                {if $certModel->getIsRequestedRefund() eq 1}
                <tr>
                    <td>退款状态</td>
                    <td>{$certModel->getRefundStatus()}</td>
                </tr>
                {/if}
                <tr>
                    <td>订单号</td>
                    <td>{if $certModel->getTrustoceanId() eq ""}----{else}{$certModel->getTrustoceanId()}{/if}</td>
                </tr>
                <tr>
                    <td>重签?</td>
                    <td>{if $certModel->getReissue() eq 0}不是{else}是{/if}</td>
                </tr>
                <tr>
                    <td>续费?</td>
                    <td>{if $certModel->getRenew() eq 0}不是{else}是 (符合条件的情况下赠送30-90天){/if}</td>
                </tr>
                <tr>
                    <td>证书编号</td>
                    <td>{if $certModel->getCertificateId() eq ""}----{else}{$certModel->getCertificateId()}{/if}</td>
                </tr>
                <tr>
                    <td>提交时间</td>
                    <td>{if $certModel->getSubmittedAt() eq ""}----{else}{$certModel->getSubmittedAt()}{/if}</td>
                </tr>
                <tr>
                    <td>过期时间</td>
                    <td>{$validTo}</td>
                </tr>
                <tr>
                    <td>颁发机构订单号</td>
                    <td>{if $certModel->getVendorId() eq ""}----{else}{$certModel->getVendorId()}{/if}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="tab-pane" id="tabDomains">
        <pre>{foreach from=$domains item=$domain}{$domain}
{/foreach}</pre>
    </div>
    <div class="tab-pane" id="tabOrg">
        {if $certModel->getClass() eq "dv"}
            此证书无需提供企业/组织信息
        {elseif $orgInfo['organization_name'] eq ""}
            用户还未提供企业/组织信息
        {else}
            <table class="datatable to-table" width="100%">
                <tbody>
                    <tr>
                        <td width="150px;">名称</td>
                        <td>{if $orgInfo['organization_name'] eq ""}----{/if} {$orgInfo['organization_name']}</td>
                    </tr>
                    <tr>
                        <td>编号</td>
                        <td>{if $orgInfo['registered_no'] eq ""}----{/if} {$orgInfo['registered_no']}</td>
                    </tr>
                    <tr>
                        <td>成立日期</td>
                        <td>{if $orgInfo['date_of_incorporation'] eq ""}----{/if} {$orgInfo['date_of_incorporation']}</td>
                    </tr>
                    <tr>
                        <td>国家</td>
                        <td>{if $orgInfo['country'] eq ""}----{/if} {$orgInfo['country']}</td>
                    </tr>
                    <tr>
                        <td>地区</td>
                        <td>{if $orgInfo['state'] eq ""}----{/if} {$orgInfo['state']}</td>
                    </tr>
                    <tr>
                        <td>城市</td>
                        <td>{if $orgInfo['city'] eq ""}----{/if} {$orgInfo['city']}</td>
                    </tr>
                    <tr>
                        <td>邮政编码</td>
                        <td>{if $orgInfo['postal_code'] eq ""}----{/if} {$orgInfo['postal_code']}</td>
                    </tr>
                    <tr>
                        <td>办公地址</td>
                        <td>{if $orgInfo['registered_address_line1'] eq ""}----{/if} {$orgInfo['registered_address_line1']}</td>
                    </tr>
                    <tr>
                        <td>组织电话</td>
                        <td>{if $orgInfo['organization_phone'] eq ""}----{/if} {$orgInfo['organization_phone']}</td>
                    </tr>
                    <tr>
                        <td>联系人</td>
                        <td>{if $orgInfo['contact_lastname'] eq ""}----{/if} {$orgInfo['contact_lastname']} {$orgInfo['contact_firstname']}</td>
                    </tr>
                    <tr>
                        <td>联系人职位</td>
                        <td>{if $orgInfo['contact_title'] eq ""}----{/if} {$orgInfo['contact_title']}</td>
                    </tr>
                    <tr>
                        <td>联系人电话</td>
                        <td>{if $orgInfo['contact_phone'] eq ""}----{/if} {$orgInfo['contact_phone']}</td>
                    </tr>
                </tbody>
            </table>
        {/if}
    </div>
    <div class="tab-pane" id="tabCert">
        {if $certModel->getCertCode() eq ""}
            证书还未签发
        {else}
            <pre>{$certModel->getCertCode()}</pre>
        {/if}
    </div>
    <div class="tab-pane" id="tabCsr">
        {if $certModel->getCsrCode() eq ""}
            用户还未提交CSR信息
            {else}
            <p>CSR信息: </p>
            <table class="datatable to-table" width="100%">
                <tbody>
                    <tr>
                        <td width="150px;">主题</td>
                        <td>{$csrInfo['CN']}</td>
                    </tr>
                    <tr>
                        <td>组织</td>
                        <td>{if $csrInfo['O'] eq ""}----{else}{$csrInfo['O']}{/if}</td>
                    </tr>
                    <tr>
                        <td>部门</td>
                        <td>{if $csrInfo['OU'] eq ""}----{else}{$csrInfo['OU']}{/if}</td>
                    </tr>
                    <tr>
                        <td>邮箱</td>
                        <td>{if $csrInfo['emailAddress'] eq ""}----{else}{$csrInfo['emailAddress']}{/if}</td>
                    </tr>
                    <tr>
                        <td>国家</td>
                        <td>{if $csrInfo['C'] eq ""}----{else}{$csrInfo['C']}{/if}</td>
                    </tr>
                    <tr>
                        <td>地区</td>
                        <td>{if $csrInfo['ST'] eq ""}----{else}{$csrInfo['ST']}{/if}</td>
                    </tr>
                    <tr>
                        <td>城市</td>
                        <td>{if $csrInfo['L'] eq ""}----{else}{$csrInfo['L']}{/if}</td>
                    </tr>
                </tbody>
            </table>
            <p>CSR内容: </p>
            <pre>{$certModel->getCsrCode()}</pre>
        {/if}
    </div>
    <div class="tab-pane" id="tabChains">
        {if $certModel->getCaCode() eq ""}
            证书还未签发
            {else}
            <pre>{$certModel->getCaCode()}</pre>
        {/if}
    </div>
    <div class="tab-pane" id="tabDCV">
        <table class="datatable" width="100%">
            <thead>
            <tr>
                <th style="text-align: left;padding: 10px;">域名</th>
                <th style="text-align: left;padding: 10px;">验证方式</th>
                <th style="text-align: left;padding: 10px;">验证状态</th>
                <th style="text-align: left;padding: 10px;">操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$dcvInformation key=domainName item=info}
                <tr>
                    <td style="padding: 10px;">{$domainName}</td>
                    <td style="padding: 10px;width: 100px;">{$info.method|upper}</td>
                    <td style="padding: 10px;width: 100px;">{$info.status}</td>
                    <td style="padding: 10px;width: 100px;">
                        {if $info.status neq "verified"}
                            <button type="button" onclick="TRUSTOCEANSSLModelApp.removeDomainModel('{$domainName}')" class="btn btn-xs btn-danger">删除</button>
                        {else}
                            ----
                        {/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
{* 操作确认 Model *}
<div class="modal fade" id="modalModuleTrustOceanRemoveDomain" role="dialog" aria-labelledby="ModuleTrustOceanRemoveDomainLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content panel panel-primary">
            <div id="modalModuleTrustOceanRemoveDomainHeading" class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="ModuleTrustOceanRemoveDomainLabel">您确定删除此域名吗?</h4>
            </div>
            <div id="modalModuleTrustOceanRemoveDomainBody" class="modal-body panel-body">
                <p>如果您无法验证此证书当中的某条域名, 您可以选择暂时移除它, 但您无法移除已经通过验证的域名.</p>
            </div>
            <div id="modalModuleTrustOceanRemoveDomainFooter" class="modal-footer panel-footer">
                <button type="button" id="ModuleTrustOceanRemoveDomain-Yes" class="btn btn-primary" onclick="TRUSTOCEANSSLModelApp.removeDomain()">
                    Yes
                </button><button type="button" id="ModuleTrustOceanRemoveDomain-No" class="btn btn-default" data-dismiss="modal">
                    No
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalModuleTrustOceanRevocationSSL" role="dialog" aria-labelledby="ModuleTrustOceanRevocationSSLLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content panel panel-primary">
            <div id="modalModuleTrustOceanRevocationSSLHeading" class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="ModuleTrustOceanRevocationSSLLabel">您确定吊销此证书吗?</h4>
            </div>
            <div id="modalModuleTrustOceanRevocationSSLBody" class="modal-body panel-body">
                <p>吊销原因: </p>
                <select class="form-control" name="revocationReason">
                    <option value="Domain name(s) is suspected of infringement or counterfeiting.">域名或网站涉嫌侵权和伪造</option>
                    <option value="Fish or fake site found, need to revoke.">此证书包含了钓鱼或假冒网站的域名</option>
                    <option value="Spread virus software found on these site(s).">网站传播病毒软件或存在非法内容</option>
                    <option value="Issuing error.">由于操作失误导致的错误签发</option>
                </select>
                <p style="margin-top: 10px;">此操作不会请求退款，仅吊销证书, 吊销请求将会实时发送至证书颁发机构. 吊销状态最快可以在1-15个自然日内在公开的CRL、OCSP服务器或公开数据库中查询到。</p>
            </div>
            <div id="modalModuleTrustOceanRevocationSSLFooter" class="modal-footer panel-footer">
                <button type="button" id="ModuleTrustOceanRevocationSSL-Yes" class="btn btn-primary" onclick="TRUSTOCEANSSLModelApp.revokeSSL()">
                    Yes
                </button><button type="button" id="ModuleTrustOceanRevocationSSL-No" class="btn btn-default" data-dismiss="modal">
                    No
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    // 初始化应用参数
    TRUSTOCEANSSLModelApp.userId = "{$smarty.session.uid}";
    TRUSTOCEANSSLModelApp.serviceId = "{if $smarty.get.productselect neq ""}{$smarty.get.productselect}{else}{$smarty.get.id}{/if}";
</script>