#ifndef RESOURCE_HPP
#define RESOURCE_HPP

#include <string>
#include <map>
#include <memory>

template <class ResourceType>
class Resource
{
    public:
        template <class ResourceLoader>
        Resource(const std::string &p_path, ResourceLoader p_loader) : m_path(p_path)
        {
            Load(p_path, p_loader);
            return;
        }

        template <class ResourceLoader>
        static void Load(const std::string &p_path, ResourceLoader p_loader)
        {
            if(!m_cache.Contains(p_path))
                m_cache.AddResource(p_path, p_loader(p_path));

            return;
        }

        static void Unload(const std::string &p_path)
        {
            m_cache.RemoveResource(p_path);
        }

        ResourceType& Get() const
        {
            return m_cache.GetResource(m_path);
        }

    private:
        std::string m_path;

        class ResourceCache
        {
            public:
                void AddResource(const std::string &p_path, std::unique_ptr<ResourceType> p_resource)
                {
                    m_rmap[p_path] = std::move(p_resource);
                    return;
                }

                void RemoveResource(const std::string &p_path)
                {
                    m_rmap.erase(p_path);
                    return;
                }

                ResourceType& GetResource(const std::string &p_path) const
                {
                    return *(m_rmap.at(p_path));
                }

                bool Contains(const std::string &p_path) const
                {
                    return (m_rmap.end() != m_rmap.find(p_path));
                }
            private:
                std::map<std::string, std::unique_ptr<ResourceType>> m_rmap;
        };

        static ResourceCache m_cache;
};

template <class ResourceType>
typename Resource<ResourceType>::ResourceCache Resource<ResourceType>::m_cache;

#endif
