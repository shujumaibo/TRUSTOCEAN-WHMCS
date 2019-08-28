<style type="text/css">
    .tohide{
        display: none;
    }
    .tohide2{
        display: none;
    }
</style>

<div class="section" style="text-align: left;">
    <div class="section-header" style="margin: 0px 15px;">
        <h3>预先验证域名</h3>
        <p>提交签发之前，您需要为每条域名分别选择域名验证方式并根据验证说明完成域名控制权验证, 如果同时存在多条子域名, 您仅需要为顶级域名验证即可。</p>
        {if $vars.error}
            {include file="$template/includes/alert.tpl" type="error" msg=$vars.error textcenter=false idname="alertModuleCustomButtonFailed"}
        {/if}
        {if $vars.info}
            {include file="$template/includes/alert.tpl" type="success" msg=$vars.info textcenter=false idname="alertModuleCustomButtonFailed"}
        {/if}
    </div>
    <div class="text-danger">{$error}</div>
    <ul class="tabul list-group list-group-tab-nav" style="margin: 0px 15px;">
        <button onclick="$('.dnd-info').toggle();" data-dcv class="btn btn-sm btn-default btn-se1" data-toggle="tab">{$MODLANG.trustoceanssl.enroll.setup3.dndinfo}</button>
    </ul>
    <div class="dnd-info" style="display: none;margin: 0px 15px;">
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvdns1}
        </p>
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvdns2} </p>
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvhttp1}
        </p>
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvhttp2}</p>
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvhttps1}
        </p>
        <p>
            {$MODLANG.trustoceanssl.enroll.setup3.dcvhttps2}</p>
    </div>
    <div class="section-body">
        <form action="clientarea.php?action=productdetails&id={$serviceid}" method="post">
            <input name="modop" value="custom" hidden>
            <input name="a" value="trySubmittoca" hidden>
        <div class="" data-inputs-container="">
            <div class="panel-body">
                <div class="table-container clearfix" style="border:none;max-height: none;">
                    <table id="tableDCVDomainList" class="table to-dcv-table">
                        <thead>
                            <tr>
                                <th data-priority="1" ><span><span>{$MODLANG.trustoceanssl.enroll.setup3.table.domain}</span><span class="sorting-arrows"></span></span></th>
                                <th data-priority="2"><span><span>{$MODLANG.trustoceanssl.enroll.setup3.table.status}</span><span class="sorting-arrows"></span></span></th>
                                <th data-priority="3"><span><span>{$MODLANG.trustoceanssl.enroll.setup3.table.method}</span><span class="sorting-arrows"></span></span></th>
                            </tr>
                        </thead>
                        <tbody>
                        {foreach from=$vars.dcvinfo key=domain item=info}
                            <tr class="domaininfo">
                                <td>{$domain}</td>
                                <td>
                                    {if $info.status eq 'needverification'}
                                        <span class="text-warning" style="padding-left: 10px;"><i class="oi fa fa-spin" data-glyph="aperture" style="margin-left: -18px;margin-top: 2px; position: absolute; padding-bottom: 2px;"></i> {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.status.needverification}</span>
                                    {elseif $info.status eq 'verified'}
                                        {if $info.method === 'email'}
                                            <span class="text-info" style="padding-left: 10px;"><i class="oi" data-glyph="circle-check" style="margin-left: -18px;margin-top: 2px; position: absolute; padding-bottom: 2px;"></i> {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.status.waitingemail}</span><br>{$info.email}
                                        {else}
                                            <span class="text-success" style="padding-left: 10px;"><i class="oi" data-glyph="circle-check" style="margin-left: -18px;margin-top: 2px; position: absolute; padding-bottom: 2px;"></i> {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.status.verified}</span>
                                        {/if}
                                    {/if}
                                </td>
                                <td style="display: flex;">
                                {*<form style="display: flex;" action="{$smarty.server.PHP_SELF}?action=productdetails&id={$vars.serviceid}&modop=custom&a=setdcvforall" method="post">*}
                                 <select name="domaindcvmathod[{$domain}]" {if $domain === $vars.domains.0}data-maindcv="true"{else}data-sandcv="true"{/if} dcv-cert-id={$serviceid} dcv-domain-name={$domain} dcv-domain={$domain|md5} class="form-control input-sm" style="width: 120px; text-align: center;" {if $info.method neq 'email'}{if $info.status eq 'verified'}disabled{/if}{/if}>
                                     <option data-method="dns" value="dns" {if $info.method eq 'dns'}selected{/if} {if $info.isip eq 'true'}disabled{/if} {if $info.isip eq 'true'}style="display:none;"{/if}>{$MODLANG.trustoceanssl.enroll.setup3.table.dns}</option>
                                     <option data-method="http" value="http" {if $info.method eq 'http'}selected{/if}>{$MODLANG.trustoceanssl.enroll.setup3.table.http}</option>
                                     <option data-method="https" value="https" {if $info.method eq 'https'}selected{/if}>{$MODLANG.trustoceanssl.enroll.setup3.table.https}</option>
                                    {if $info.isip eq 'false'}
                                        <option disabled> {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.emaildesc}</option>
                                        {foreach from=$info.dcvemails key=emailkey item=email}
                                            {assign var=emailVar value="@"|explode:$email}
                                            <option value="{$email}" data-method="email" data-mailname="{$emailVar.0}" data-emailkey="{$emailkey}" data-maildomain="{$emailVar.1}" {if $info.email}{if $info.email eq $email}selected{/if}{/if}>{$email}</option>
                                        {/foreach}
                                    {/if}
                                 </select>

                                    {if $domain === $vars.domains.0}
                                    <input type="button" onclick="selectAllDcvMethod()" data-toggle="tooltip" data-title="{$MODLANG.trustoceanssl.enroll.setup3.table.selectalldesc}" data-original-title="" title="" class="btn btn-xs btn-default" value="{$MODLANG.trustoceanssl.enroll.setup3.table.selectall}">
                                    {/if}
                                    {*</form>*}
                                </td>
                                <td>
                                    {if $info.status === "needverification"}
                                    <form action="{$smarty.server.PHP_SELF}?action=productdetails&id={$vars.serviceid}&modop=custom&a=removeDomain" method="post">
                                    <input name="domain" value="{$domain}" hidden>
                                        <input type="submit" data-toggle="tooltip" data-title="{$MODLANG.trustoceanssl.enroll.setup3.table.removedesc}" data-original-title="" title="" class="btn btn-xs btn-danger" value="{$MODLANG.trustoceanssl.enroll.setup3.table.remove}">
                                    </form>
                                    {/if}
                                </td>
                            </tr>
                            <tr dcv-tds="{$domain|md5}" {if $info.status eq 'verified'}style="display: none;"{/if}>
                                <td colspan="4" dcv-change style="display: none;">
                                    <p>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.change.process}</p>
                                </td>
                                <td colspan="4" dcv-tab="dns" {if $info.method neq 'dns'}style="display: none;"{/if}>
                                    <p>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.host}: <span class="yate dcv-dnsinfo">{$vars.csrhash.dns.purehost}{if $info.subdomain neq ''}.{$info.subdomain}{/if}</span> <button class="btn btn-xs btn-info" data-clipbutton data-clipboard-text="{$vars.csrhash.dns.purehost}{if $info.subdomain neq ''}.{$info.subdomain}{/if}">{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.copy}</button>
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.type}: <span class="yate">{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.typecname}</span>
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.point}: <p class="yate dcv-dnsinfo">{$vars.csrhash.dns.purevalue|strtolower}.{$vars.uniqueid|strtolower}.comodoca.com</p> <button class="btn btn-xs btn-info" data-clipbutton data-clipboard-text="{$vars.csrhash.dns.purevalue|strtolower}.{$vars.uniqueid|strtolower}.comodoca.com">{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.copy}</button>
                                    </p>
                                </td>
                                <td colspan="4" dcv-tab="http" {if $info.method neq 'http'}style="display: none;"{/if}>
                                    <p>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.download}: <span class="yate"><a href="javascript:;" onclick="dcvDownloadFile('{$vars.csrhash.http.firstline}\ncomodoca.com\n{$vars.uniqueid|strtolower}','{$vars.csrhash.http.filename}');">{$vars.csrhash.http.filename}</a></span>
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.upload}: http://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well-known/pki-validation/  {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.folder}
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.access}: <span class="yate">
                                            <a href="http://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well-known/pki-validation/{$vars.csrhash.http.filename}" target="_blank">
                                                http://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well‐known/pki‐validation/{$vars.csrhash.http.filename}
                                            </a>
                                        </span>
                                    </p>
                                </td>
                                <td colspan="4" dcv-tab="https" {if $info.method neq 'https'}style="display: none;"{/if}>
                                    <p>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.download}: <span class="yate"><a href="javascript:;" onclick="dcvDownloadFile('{$vars.csrhash.http.firstline}\ncomodoca.com\n{$vars.uniqueid|strtolower}','{$vars.csrhash.http.filename}');">{$vars.csrhash.http.filename}</a></span>
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.upload}: https://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well-known/pki-validation/ {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.folder}
                                        <br>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.access}: <span class="yate">
                                            <a href="https://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well-known/pki-validation/{$vars.csrhash.http.filename}" target="_blank">
                                                https://{if $info.subdomain}{$info.subdomain}.{/if}{$info.topdomain}/.well‐known/pki‐validation/{$vars.csrhash.http.filename}
                                            </a>
                                        </span>
                                    </p>
                                </td>
                            </tr>
                        {/foreach}
                        {literal}
                        <script>
                            function selectAllDcvMethod() {
                                var b = $("select[data-maindcv] option:selected").attr("data-method");
                                console.log(b);
                                if ("email" === b) {
                                    var c = $("select[data-maindcv] option:selected");
                                    $("select[data-sandcv]").each(function() {
                                        var a = $(this).children("option");
                                        var that = this;
                                        $(a).each(function() {
                                            if($(this).attr("data-emailkey") === c.attr("data-emailkey")){
                                                $(that).val($(this).val()).trigger("change");
                                                //$(this).attr("selected", !0).trigger("change")
                                            }
                                            // else{
                                            //     $(this).removeAttr("selected").trigger("change")
                                            // }

                                        })
                                    })
                                }
                                if("dns" === b){
                                    $("select[data-sandcv]").each(function() {
                                    var a = $(this).children("option");
                                    var that = this;
                                    $(a).each(function() {
                                        if($(this).attr("data-method") === "dns"){
                                            $(that).val($(this).val()).trigger("change");
                                            // $(this).attr("selected", !0).trigger("change")
                                        }
                                        // else{
                                        //     $(this).removeAttr("selected").trigger("change")
                                        // }
                                    })
                                })}
                                if("http" === b){
                                    $("select[data-sandcv]").each(function() {
                                    var a = $(this).children("option");
                                    var that = this;
                                    $(a).each(function() {
                                        if($(this).attr("data-method") === "http"){
                                            $(that).val($(this).val()).trigger("change");
                                            // $(this).attr("selected", !0).trigger("change")
                                        }
                                        // else{
                                        //     $(this).removeAttr("selected").trigger("change")
                                        // }
                                    })
                                })}
                                if("https" === b){
                                    $("select[data-sandcv]").each(function() {
                                    var a = $(this).children("option");
                                    var that = this;
                                    $(a).each(function() {
                                        if($(this).attr("data-method") === "https"){
                                            $(that).val($(this).val()).trigger("change");
                                            // $(this).attr("selected", !0).trigger("change")
                                        }
                                        // else{
                                        //     $(this).removeAttr("selected").trigger("change")
                                        // }
                                    })
                                })}
                            }
                        </script>
                        {/literal}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <p style="color: #909090;">
            {$MODLANG.trustoceanssl.enroll.setup3.table.dcv.submit.desc}</p>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary"  data-serviceid="{$serviceid}" data-loading-text="请稍等..." style="margin-right: 30px;"/>{$MODLANG.trustoceanssl.enroll.setup3.table.dcv.submit.btn}</a>
        </div>
        </form>
    </div>
</div>