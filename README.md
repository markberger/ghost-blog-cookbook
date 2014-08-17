ghost-blog Cookbook
===================
A cookbook for deploying the open source bloging platform [ghost](https://github.com/tryghost/Ghost) with sqlite3.

Much of this cookbook is a fork of Ryan Walker's [chef-ghost](https://github.com/ryandub/chef-ghost) cookbook.

Requirements
------------
- `berkshelf`
- `nodejs`
- `nginx`

Attributes
----------
#### ghost-blog::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:ghost][:user]</tt></td>
    <td>string</td>
    <td><tt>"ghost"</tt></td>
  </tr>
  <tr>
    <td><tt>[:ghost][:include_dev_config]</tt></td>
    <td>bool</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>[:ghost][:sqlite_path_dev]</tt></td>
    <td>string</td>
    <td><tt>"/content/data/ghost-dev.db"</tt></td>
  </tr>
  <tr>
    <td><tt>[:ghost][:sqlite_path_prod]</tt></td>
    <td>string</td>
    <td><tt>"/content/data/ghost.db"</tt></td>
  </tr>
  <tr>
    <td><tt>[:ghost][:domain]</tt></td>
    <td>string</td>
    <td><tt>"ghost.example.com"</tt></td>
  </tr>
  <tr>
    <td><tt>[:ghost][:blog_addr]</tt></td>
    <td>string</td>
    <td><tt>"127.0.0.1"</tt></td>
  </tr>
  <tr>
	<td><tt>[:ghost][:port]</tt></td>
	<td>string</td>
	<td><tt>"2368"</tt></td>
  </tr>
  <tr>
	<td><tt>[:ghost][:install_path]</tt></td>
	<td>string</td>
	<td><tt>"/home/ghost"</tt></td>
  </tr>
  <tr>
	<td><tt>[:ghost][:src_url]</tt></td>
	<td>string</td>
	<td><tt>"https://ghost.org/zip/ghost-0.5.0.zip"</tt></td>
  <tr>
</table>

Usage
-----
#### ghost-blog::default

Set the `user` to own and run the instance of ghost. Also set the
`install_path` and `domain` variables if applicable. Finally include `ghost-blog`
in a recipe or your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ghost-blog]"
  ]
}
```

If you would like to use nginx to serve the ghost instance, use the recipe
`ghost-blog::nginx`.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a pull request using Github

License and Authors
-------------------
Authors: Mark J. Berger

License: Apache 2.0

