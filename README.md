<h2>SimpleTemplate</h2>
<p>A vim plugin for creating file from template.SimplateTemplate can set filetype by the postfix of template file.And if there is no postfix the filetype will be setted 'vim'.</p>

<h3>Usage</h3>
<p>Create a new file in current window</p>
<pre>:SimpleTemplate template.php</pre>
<p>Create a new file in new tab</p>
<pre>:SimpleTemplateTab template.php</pre>

<h3>Config Attribute</h3>
<p>You can define a global variable for configuration.The variable name must be 'g:SimpleTemplate'.</p>
<pre>
let g:SimplateTemplate = {
    "template path
    \'path':'~/template/',
    \'default_name':'noname',
    \'cursor':'#cursor',
    \'flags':[
        \{
            \'key':'#author#',
            \'value':'wondger'
        \},
        \{
            \'key':'#date#',
            \'value':'#date#'
        \}
    \]
}
</pre>
<p>There are tow system value you can use:</p>
<ul>
    <li>#date# - current date time</li>
    <li>#filename# - file name</li>
</ul>
<p>The keys in flags will be replaced by the value when load template file.</p>

<h3>Example</h3>
<p>template file</p>
<pre>
/*
 * @name   : Super Man
 * @author : __author__
 * @crate  : __date__
*/
#cursor#
</pre>
<p>config</p>
<pre>
let g:SimplateTemplate = {
    "template path
    \'path':'~/template/',
    \'default_name':'noname',
    \'cursor':'#cursor',
    \'flags':[
        \{
            \'key':'__author__',
            \'value':'wondger'
        \},
        \{
            \'key':'__date__',
            \'value':'#date#'
        \}
    \]
}
</pre>
<p>excute command:</p>
<pre>
:SimpleTemplateTab template.js
</pre>
<p>Will create a file in new tab.And it's content is:</p>
<pre>
/*
 * @name   : Super Man
 * @author : wondger
 * @crate  : 2012-04-10
*/
(cursor will move here)
</pre>
