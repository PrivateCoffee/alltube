{extends file='page.tpl'}
{block name='main'}
    {include file="inc/logo.tpl"}

    {if isset($video->title)}
        {include file='snippets/title.tpl' assign=title}
        <p>
            {t params=['@title'=>$title]}Videos extracted from @title:{/t}
        </p>
    {/if}

    {if $config->stream}
        <a href="{path_for name="download"}?url={$video->webpage_url}" class="downloadBtn">Download everything</a>
    {/if}
    {foreach $video->entries as $entry}
        <div class="playlist-entry">
            <h3 class="playlist-entry-title">
                <a target="_blank" href="{strip}
                {if isset($entry->ie_key) and $entry->ie_key == Youtube and !filter_var($entry->url, FILTER_VALIDATE_URL)}
                    https://www.youtube.com/watch?v=
                {/if}
                {$entry->url}
            {/strip}">
                    {if !isset($entry->title)}
                        {if $entry->ie_key == YoutubePlaylist}
                            {t}Playlist{/t}
                        {else}
                            {t}Video{/t}
                        {/if}
                    {else}
                        {$entry->title}
                    {/if}
                </a>
            </h3>
            {if $entry->_type == 'playlist'}
                <p class="playlist-entry-description">
                    <a target="_blank" class="downloadBtn" 
                    href="{path_for name="info"}?url={$entry->webpage_url}">{t}View playlist{/t}</a>
                </p>
            {else}
                <a target="_blank" class="downloadBtn"
                href="{path_for name="download"}?url={$entry->url}">{t}Download{/t}</a>
                <a target="_blank" href="{path_for name="info"}?url={$entry->url}">{t}More options{/t}</a>
            {/if}
        </div>
    {/foreach}
{/block}
