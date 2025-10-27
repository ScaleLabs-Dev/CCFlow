# Command: /cf:archive (PLANNED)

**STATUS**: Planned - Not yet implemented

## Purpose

Archive old completed tasks and checkpoint entries from memory bank files to prevent unbounded growth.

## Planned Usage

```
/cf:archive                    # Interactive mode
/cf:archive --tasks            # Archive old tasks
/cf:archive --checkpoints      # Archive old checkpoints
```

## Design Decisions Needed

1. **Archive triggers**: By age (days)? By count (keep N recent)? By file size?
2. **Archive destination**: Appendix in same file? Separate archive file? Delete (git history)?
3. **Default thresholds**: How old is "old"? (30 days? 60 days? 90 days?)

## Notes

- Deferred to post-Phase 3 (see pre-init-decisions.md ACTION 10)
- Users can manually edit memory bank markdown files in interim
- Git history preserves all changes if recovery needed
- May add auto-archive suggestions to /cf:checkpoint in future

---

**To implement**: Use `/cf:refine-command archive` or create from scratch after gathering user feedback on archival needs

**Created**: 2025-10-09
