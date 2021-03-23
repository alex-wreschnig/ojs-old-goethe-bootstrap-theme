{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

{if $navigationMenu}
	<ul id="{$id|escape}" class="{$ulClass|escape} {if $id != "main-navigation"}{if $isUserLoggedIn}loggedIn{else}loggedOut{/if}{/if}">
		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			{assign var="hasChildren" value=false}
			{if !empty($navigationMenuItemAssignment->children)}
				{assign var="hasChildren" value=true}
			{/if}
			<li class="{$liClass|escape} menu-item-{$navigationMenuItemAssignment->getMenuItemId()}{if $hasChildren} dropdown{else}{if $currentUrl == $navigationMenuItemAssignment->navigationMenuItem->getUrl()} current{/if}{/if}">
				<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"{if $hasChildren} class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"{/if}>
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
					{if $hasChildren}
						<span class="caret"></span>
					{/if}
				</a>
				{if !empty($navigationMenuItemAssignment->children)}
					<ul class="dropdown-menu {if $id === 'navigationUser'}dropdown-menu-right{/if}">
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								<li class="{$liClass|escape} menu-item-{$childNavigationMenuItemAssignment->getMenuItemId()}{if $currentUrl == $childNavigationMenuItemAssignment->navigationMenuItem->getUrl()} current{/if}">
									<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
										{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
									</a>
								</li>
							{/if}
						{/foreach}
					</ul>
				{/if}
			</li>
		{/foreach}
	</ul>
{/if}
